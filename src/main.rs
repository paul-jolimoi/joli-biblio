#![feature(proc_macro_hygiene, decl_macro)]

#[macro_use] extern crate rocket;
#[macro_use] extern crate rocket_contrib;

use rocket_contrib::databases::rusqlite::{self, types::ToSql, Connection};

#[derive(Debug)]
struct Author {
    id_author: i32,
    firstname: String,
    lastname: String
}

#[database("sqlite_db")]
struct DbConnection(Connection);

#[get("/")]
fn status_api() -> &'static str {
    "Api is running !"
}

fn get_author_service(connection: &Connection, id: i32)-> Author {
    return connection.query_row(
        "SELECT id_author, firstname, lastname FROM jb_author where id_author = ?", 
        &[&id as &dyn ToSql],
        |row| {
            Author {
                id_author: row.get(0),
                firstname: row.get(1),
                lastname: row.get(2)
            }
    }).expect("Not Author found for the given id");
}

#[get("/authors/<id>")]
fn get_author(connection: DbConnection, id: i32) -> Result<String, String> {
    let author: Author = get_author_service(&*connection, id);
    
    Ok(format!("Firstname : {}, Lastname : {}, Id: {}", author.firstname, author.lastname, author.id_author).into())
}


fn main() {
    rocket::ignite()
    .attach(DbConnection::fairing())
    .mount("/", routes![status_api, get_author]).launch();
}

