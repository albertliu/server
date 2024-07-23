'use strict';

const db = require("../utils/mssqldb");
var pdf = require("../utils/pdf");
const env = process.env.NODE_ENV_BACKEND;
let response, sqlstr, params;

const comFunc = {
    generate_entryform_sign: function (enterID){
        if (enterID > 0) {
            let filename1 = "";
            let path = "";
            //publish diploma on A4 with pdf
            sqlstr = "updateEnterMaterials";
            //params = {enterID:req.query.enterID, filename:filename, filename1:filename1};
            path = 'users/upload/students/firemanMaterials/' + enterID + '_4.pdf';
            filename1 = path.replace("users/", "/");
            params = { enterID: enterID, filename1: "", filename2: "", filename3: "", filename4: filename1 };
            //generate diploma data
            // console.log("params:", params);
            db.excuteProc(sqlstr, params, function (err, data) {
            if (err) {
                console.log(err);
                response = [];
                return res.send(response);
            }
            // console.log("data:", data.recordset[0]);
            let entryform = data.recordset[0]["entryForm"];  //报名表样式
            let username = data.recordset[0]["username"];  //报名表样式
            //班级归档资料
            let str = env + "/entryform_" + entryform + ".asp?public=1&nodeID=" + enterID + "&refID=" + username + "&keyID=4";
            pdf.genPDF([str], [path], '210mm', '290mm', '', false, 1, false);
            //return publish file path
            return [filename1];
            });
        } else {
            return [];
        }
    }
}

module.exports = comFunc;