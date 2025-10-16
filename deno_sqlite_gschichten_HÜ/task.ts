import { DatabaseSync } from "node:sqlite";

const db = new DatabaseSync("2ahwii.db");

const insBf = db.prepare("insert into students(name, birthdate) values (?, ?)");
const selBf = db.prepare("select * from students where id > ?");
const updateBf = db.prepare("update students set birthdate = ? where name = ?");
const delBf = db.prepare("delete from students where name = ?");

insBf.run("Anton", "2010-10-11");
selBf.run(5);
updateBf.run("2011-11-12","Alex");
delBf.run("anton");

