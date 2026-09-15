# 310115197912170021
# 密码170021

import json
import time
import re
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
import os
import pymssql

env_dist = os.environ

# 数据库连接
conn = pymssql.connect(
    server=env_dist.get('NODE_ENV_DB'),
    port="14333",
    user="sqlrw",
    password=env_dist.get('NODE_ENV_DB_PASSWD'),
    database="elearning",
    autocommit=True,
    tds_version="7.0"
)


def parse_css_whitelist(driver):
    """解析页面style标签，提取有效字符class白名单（opacity:1!important）"""
    style_elements = driver.find_elements(By.CSS_SELECTOR, "style")
    white_set = set()
    for style_ele in style_elements:
        css_text = style_ele.get_attribute("innerHTML")
        if "opacity:1!important;" not in css_text:
            continue
        part = css_text.split("{opacity:1!important;}")[0]
        class_list_raw = part.split(",")
        for cls in class_list_raw:
            c = cls.strip().lstrip(".")
            if c:
                white_set.add(c)
    return white_set


def trigger_answer_for_one(driver, q_index, max_wait_sec=4.0):
    """JS触发点击+change事件"""
    start = time.time()
    js_script = '''
    const contents = document.querySelectorAll(".test-content > .content");
    const qEl = contents[arguments[0]];
    if(!qEl) return {"found_answer_mark":false,"has_right_tip":false,"text":""};
    const radio = qEl.querySelector(".answer-option .option input[type='radio']");
    if(!radio) return {"found_answer_mark":false,"has_right_tip":false,"text":""};
    radio.click();
    radio.dispatchEvent(new Event('change'));
    const ansBlock = qEl.querySelector(".answer-option > div:last-child");
    const txt = ansBlock ? ansBlock.innerText : "";
    return {
        "found_answer_mark": txt.includes("正确答案是："),
        "has_right_tip": txt.includes("答题正确") || txt.includes("答案正确"),
        "text": txt
    };
    '''
    found_answer_mark = False
    has_right_tip = False
    final_raw_text = ""
    while time.time() - start < max_wait_sec:
        ret = driver.execute_script(js_script, q_index)
        final_raw_text = ret.get("text", "")
        found_answer_mark = ret.get("found_answer_mark", False)
        has_right_tip = ret.get("has_right_tip", False)
        if found_answer_mark or has_right_tip:
            break
        time.sleep(0.3)
    return found_answer_mark, has_right_tip, final_raw_text


def parse_one_question(driver, q_index, white_class_set):
    """q_index: 当前页内题号索引（0开始），全部逻辑在浏览器JS执行"""
    js_parse = '''
    const contents = document.querySelectorAll(".test-content > .content");
    const el = contents[arguments[0]];
    const whiteSetRaw = arguments[1];
    const whiteSet = new Set(whiteSetRaw);
    const res = {
        question_no:"",
        question_type:"",
        stem_text:"",
        stem_img:"",
        options:[],
        right_answer:"",
        analysis:"",
        answer_source:""
    };
    const noSpan = el.querySelector(".test-description span:first-of-type");
    if(noSpan) res.question_no = noSpan.textContent.trim();
    const typeSpan = el.querySelector(".test-title .title_type span");
    if(typeSpan) res.question_type = typeSpan.textContent.trim();

    let stemText = "";
    let stemParts = [];
    el.querySelectorAll(".against-wrapper.box .against-inner").forEach(div=>{
        const spans = div.querySelectorAll("span");
        for(let sp of spans){
            const clsArr = sp.className.split(" ");
            const lastCls = clsArr[clsArr.length-1];
            if(whiteSet.has(lastCls)){
                stemParts.push(sp.textContent);
                break;
            }
        }
    });
    if(stemParts.length > 0){
        stemText = stemParts.join("").trim();
    }
    if(!stemText){
        const titleBox = el.querySelector(".test-description .title-img-box");
        if(titleBox){
            const clone = titleBox.cloneNode(true);
            clone.querySelectorAll("img").forEach(img => img.remove());
            stemText = (clone.textContent || "").trim();
        }
    }
    if(!stemText){
        const descEl = el.querySelector(".test-description");
        if(descEl){
            const clone = descEl.cloneNode(true);
            const firstSpan = clone.querySelector("span");
            if(firstSpan) firstSpan.remove();
            clone.querySelectorAll("img").forEach(img => img.remove());
            stemText = (clone.textContent || "").trim();
        }
    }
    res.stem_text = stemText;

    const stemImg = el.querySelector(".test-description .title-img-box img");
    res.stem_img = stemImg ? stemImg.src : "";

    const optEls = el.querySelectorAll(".answer-option .option");
    optEls.forEach(optEl=>{
        let opt_img = "";
        const img = optEl.querySelector(".option-img-box img, .el-radio__label img");
        if(img) opt_img = img.src;
        let labelText = optEl.querySelector(".el-radio__label").textContent.trim();
        labelText = labelText.replace(/^[A-Za-z][.．]\\s*/, '');
        res.options.push({"opt_text":labelText,"opt_img":opt_img||""});
    });

    const ansBlock = el.querySelector(".answer-option > div:last-child");
    if(ansBlock){
        let blockText = ansBlock.innerText.trim();
        if(blockText.includes("正确答案是：")){
            const parts = blockText.split("正确答案是：");
            if(parts.length>=2){
                const rest = parts[1].split('\\n');
                res.right_answer = rest[0].trim();
                if(rest.length>=2) res.analysis = rest.slice(1).join('\\n').trim();
            }
            res.answer_source = "page";
        }else if(blockText.includes("答题正确") || blockText.includes("答案正确")){
            res.right_answer = "a";
            let analysisText = blockText.replace(/^(答题正确|答案正确)\\s*/, '').trim();
            res.analysis = analysisText;
            res.answer_source = "infer";
        }else{
            res.analysis = blockText;
            res.answer_source = "none";
        }
        if(res.analysis === "暂无解析"){
            res.analysis = "";
        }
    }
    return res;
    '''
    white_list = list(white_class_set)
    data = driver.execute_script(js_parse, q_index, white_list)

    if not data.get("right_answer"):
        data["right_answer"] = ""
    if not data.get("analysis"):
        data["analysis"] = ""
    return data


def _valid_img(url):
    """只保留有效的图片链接（http/https 开头），其余返回空字符串"""
    if not url:
        return ""
    url = str(url).strip()
    if url.startswith("http://") or url.startswith("https://"):
        return url
    return ""


def _clean(text):
    """文本统一转成字符串，None -> ''；单引号转义为两个单引号，避免 SQL 报错"""
    if text is None:
        return ""
    text = str(text).strip()
    text = text.replace("'", "''")
    return text


def flatten_question(q_data):
    """将嵌套字典转成固定 16 列的一维数组"""
    row = [
        _clean(q_data.get("question_no")),
        _clean(q_data.get("question_type")),
        _clean(q_data.get("stem_text")),
        _valid_img(q_data.get("stem_img")),
    ]

    options = q_data.get("options") or []
    for i in range(5):
        if i < len(options):
            opt = options[i] or {}
            row.append(_clean(opt.get("opt_text")))
            row.append(_valid_img(opt.get("opt_img")))
        else:
            row.append("")
            row.append("")

    row.append(_clean(q_data.get("right_answer")))
    row.append(_clean(q_data.get("analysis")))
    return row


def _make_signature(q_data):
    """题目签名：题号 + 题干前80字，用于跨页去重与循环检测"""
    no = (q_data.get("question_no") or "").strip()
    stem = (q_data.get("stem_text") or "").strip()
    return f"{no}|{stem[:80]}"


def _extract_int(text):
    """从字符串中提取纯数字部分，如 '1、' -> '1'，'第12题' -> '12'"""
    digits = re.sub(r'\D', '', str(text))
    return digits if digits else '0'


def execSQL(text: str):
    """
    执行 SQL，并确保存储过程完全执行完毕再返回。
    完整消费所有结果集（fetchall + nextset），保证服务端执行完成后才返回。
    """
    curs = conn.cursor()
    try:
        curs.execute(text)
        while True:
            try:
                curs.fetchall()
            except Exception:
                pass
            try:
                if not curs.nextset():
                    break
            except Exception:
                break
    finally:
        try:
            curs.close()
        except Exception:
            pass


def main():
    driver = webdriver.Edge()
    driver.maximize_window()
    driver.get("https://www.zaixian100f.com/exam/test_paper/show/id/37?type=basicTraining&organization_id=662246")
    print("=" * 60)
    print("请在Edge浏览器完成登录，页面加载出题目后，回到控制台按下回车！")
    input()

    all_questions = []
    seen_signatures = set()
    page_index = 1
    max_pages = 500

    try:
        while True:
            if page_index > max_pages:
                print(f"⚠️ 已达到最大页数上限 {max_pages} 页，强制结束抓取")
                break

            print(f"\n>>>> 当前处理第 {page_index} 页")
            try:
                wait = WebDriverWait(driver, 12)
                wait.until(EC.presence_of_element_located((By.CLASS_NAME, "test-content")))
            except Exception:
                print("页面未加载出题目，结束抓取")
                break

            white_cls_set = parse_css_whitelist(driver)
            count_content = driver.execute_script(
                "return document.querySelectorAll('.test-content > .content').length;"
            )
            print(f"本页检测题目数量：{count_content}")

            if count_content == 0:
                print("本页没有题目，结束抓取")
                break

            # 先解析本页所有题目（收集签名）
            page_items = []
            for q_idx in range(count_content):
                print(f"处理本页第{q_idx+1}题，触发选项作答，等待答案渲染...")
                trigger_answer_for_one(driver, q_idx, max_wait_sec=4.0)
                q_data = parse_one_question(driver, q_idx, white_cls_set)
                sig = _make_signature(q_data)
                page_items.append((sig, q_data))

            # 循环检测：整页签名都已抓取过 -> 进入循环/回到第一页
            if page_items and all(sig in seen_signatures for sig, _ in page_items):
                print("🔁 本页所有题目均已抓取过，判定为循环/结束，停止抓取")
                break

            # 只处理新题目，且每题写完库再处理下一题
            new_count = 0
            for sig, q_data in page_items:
                if sig in seen_signatures:
                    continue
                seen_signatures.add(sig)

                row = flatten_question(q_data)
                print(row)

                # ========== 只修复题号：去掉非数字字符 ==========
                # '1、' -> '1'，避免存储过程 int 参数转换失败
                q_no_int = _extract_int(row[0])

                # ========== 中间两个参数保持原样 '' ==========
                sql = ("exec addNewQuestionStudy100 '" + q_no_int + "', '" + row[1] + "', '" +
                       row[2] + "', '" + row[3] + "', '" + row[4] + "', '" + row[5] + "', '" +
                       row[6] + "', '" + row[7] + "', '" + row[8] + "', '" + row[9] + "', '" +
                       row[10] + "', '" + row[11] + "', '" + row[12] + "', '" + row[13] +
                       "','','', '" + row[14] + "', '" + row[15] + "'")
                print(sql)

                execSQL(sql)

                all_questions.append(row)
                new_count += 1

            print(f"✅ 本页新增 {new_count} 题，累计 {len(all_questions)} 题")

            if new_count == 0:
                print("本页没有新增题目，停止抓取")
                break

            # 翻页
            try:
                next_btn = driver.find_element(By.CSS_SELECTOR, ".pagin_right")
            except Exception:
                print("找不到下一页按钮，全部抓取结束")
                break

            try:
                next_btn.click()
            except Exception as e:
                print(f"点击下一页失败：{e}，全部抓取结束")
                break

            time.sleep(1.8)
            page_index += 1
    finally:
        try:
            conn.close()
        except Exception:
            pass

    # with open("exam_result.json", "w", encoding="utf-8") as f:
    #     json.dump(all_questions, f, ensure_ascii=False, indent=2)

    print(f"\n✅抓取完成！一共获取 {len(all_questions)} 道题目")
    print("\n【数据字段说明】（每行固定16列）")
    print("0  题目序号；1  题目类型；2  题干文字；3  题干图片")
    print("4  选项A文字；5  选项A图片")
    print("6  选项B文字；7  选项B图片")
    print("8  选项C文字；9  选项C图片")
    print("10 选项D文字；11 选项D图片")
    print("12 选项E文字；13 选项E图片")
    print("14 正确答案；15 题目解析")
    print("提示：所有文本字段中的英文单引号已自动转义为两个单引号（''）")
    print("提示：题号已提取为纯数字")

    input("\n按回车关闭浏览器...")
    driver.quit()


if __name__ == "__main__":
    main()