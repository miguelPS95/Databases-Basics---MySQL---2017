---------------1------------
CREATE TABLE locations (
	id INT NOT NULL AUTO_INCREMENT,
    latitude FLOAT,
    longitude FLOAT,
	PRIMARY KEY (id)
);

CREATE TABLE credentials (
	id INT NOT NULL AUTO_INCREMENT,
    email VARCHAR(30),
    password VARCHAR(20),
    PRIMARY KEY (id)
);

CREATE TABLE users (
	id INT NOT NULL AUTO_INCREMENT,
    nickname VARCHAR(25),
    gender CHAR(1),
    age INT,
    location_id INT,
    credential_id INT,
    PRIMARY KEY (id),
    CONSTRAINT fk_users_locations FOREIGN KEY (location_id) REFERENCES locations(id),
    CONSTRAINT fk_users_credentials FOREIGN KEY (credential_id) REFERENCES credentials(id),
	CONSTRAINT uk_credential_id UNIQUE (credential_id)
);

CREATE TABLE chats (
	id INT NOT NULL AUTO_INCREMENT,
    title VARCHAR(32),
    start_date DATE,
    is_active BIT,
    PRIMARY KEY (id)
);

CREATE TABLE messages (
	id INT NOT NULL AUTO_INCREMENT,
    content VARCHAR(200),
    sent_on DATE,
    chat_id INT,
    user_id INT,
    PRIMARY KEY (id),
    CONSTRAINT fk_messages_chats FOREIGN KEY (chat_id) REFERENCES chats (id),
    CONSTRAINT fk_messages_users FOREIGN KEY (user_id) REFERENCES users (id)
);

CREATE TABLE users_chats (
	user_id INT NOT NULL,
    chat_id INT NOT NULL,
    CONSTRAINT pk_users_chats PRIMARY KEY (user_id, chat_id),
    CONSTRAINT fk_users_chats_users FOREIGN KEY (user_id) REFERENCES users (id),
    CONSTRAINT fk_users_chats_chats FOREIGN KEY (chat_id) REFERENCES chats (id)
);

---------------2------------
insert into messages(content, sent_on, chat_id, user_id)
SELECT concat(concat(concat(u.age, '-', u.gender), '-', l.latitude), '-', l.longitude), '2016-12-15', if(u.gender = 'F', ceil(sqrt(u.age * 2)), round(pow(u.age / 18, 3), 0)), u.id
from users as `u`
join locations as `l`
on l.id = u.location_id
where u.id between 10 and 20;
---------------3------------
update chats as `c`
join messages as `m`
on c.id = m.chat_id
join users as `u`
on u.id = m.user_id
set c.start_date = (select min(m.sent_on) from messages as `m` where m.chat_id = c.id)
where(m.sent_on < c.start_date)
---------------4------------
DELETE FROM locations
WHERE id IN(
    SELECT l.id FROM (
	     SELECT*FROM locations
		               ) as l
    LEFT JOIN users AS u
    ON l.id=u.location_id
    WHERE u.location_id IS NULL)
---------------5------------
select nickname,gender,age
from users
where age>=22 and age<=37
order by id asc
---------------6------------
select content,sent_on
from messages
where date(sent_on)>'2014-05-12'
and content like'%just%'
order by id desc
---------------7------------
select title,is_ACTIVE
from chats
where (is_active=0 AND LENGTH (title)<5) or(substr(title,3,2)='tl')
ORDER BY TITLE DESC
---------------8------------
select  c.id,title,m.id
from chats as c
left join messages as m
on m.chat_id=c.id 
where 
date(sent_on)<'2012-03-26' and 
substr(title,-1,1)='x'
order by c.id asc,m.id asc
---------------9------------
select c.id,count(*)
from messages as m
right join chats as c
on m.chat_id=c.id
where m.id<90
group by c.id
order by count(*)desc ,c.id asc
limit 5;
---------------10------------
select nickname,email,password
from credentials as c
join users as u
on c.id=u.credential_id
where email like '%co.uk'
order by email asc
---------------11------------
select u.id,u.nickname,u.age
from locations as l
right join users as u
on l.id=u.location_id
where u.location_id is null
order by u.id asc
---------------12------------

---------------13------------
select u.nickname,c.title,l.latitude,l.longitude
from users as u
join locations as l on u.location_id=l.id
join users_chats as uc on u.id=uc.user_id
join chats as c on c.id=uc.chat_id
where (latitude between 41.139999 and 44.129999) and (longitude between 22.209999 and 28.359999)
order by c.title asc
---------------14------------

---------------15------------

---------------16------------

---------------17------------

---------------18------------

---------------19------------





