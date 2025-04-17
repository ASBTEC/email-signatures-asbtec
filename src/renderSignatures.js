#!/usr/bin/env node

// Handlebars for templating
const Handlebars = require("handlebars");
// FS to access file system from local NPM context
const fs = require("fs");


let dirPath = "./";

// Read text template and compile it
let templateText = fs.readFileSync(dirPath + "templates/template.html", "utf8");
const template = Handlebars.compile(templateText);

let data = fs.readFileSync(dirPath + "data/user.json", "utf8");
let json_data = JSON.parse(data)
let signature = template(json_data);
fs.writeFileSync(dirPath + "out/" + json_data.email + ".html", signature, {encoding: "utf8", flag: "w+", mode: 0o666 });


