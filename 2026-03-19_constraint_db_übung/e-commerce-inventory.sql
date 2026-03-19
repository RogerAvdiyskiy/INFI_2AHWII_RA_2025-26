create table categories (
    id int primary key,
    name text not null
)

create table products (

    id int primary key,
    name text,
    price int default 0.0 check (price >= 0),
    category_id int,
    constraint fk_category_id foreign key(category_id) references categories(id)
)