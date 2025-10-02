import { DB } from "sqlite_kraken/mod.ts";



const db = new DB("2ahwii.db");
db.query("insert into students (id,name,birthdate) values (16,'Darius','2010-03-04')");
const rows = [...db.query("select *from students")];
console.log(rows);
db.close();


