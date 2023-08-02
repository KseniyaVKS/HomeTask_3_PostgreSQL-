-- Task_2
-- Название и продолжительность самого длительного трека
select name, duration from tracks
where duration = (select max(duration) from tracks);

-- Название треков, продолжительность которых не менее 3,5 минут
select name from tracks
where duration >= 210;

-- Названия сборников, вышедших в период с 2018 по 2020 год включительно
select name from collections
where release between 2018 and 2020

-- Исполнители, чьё имя состоит из одного слова
select nickname from musicians
where nickname not like '% %'

-- Название треков, которые содержат слово "мой" или "my"
select name from tracks
where name like '%мой%' or name like '%my%'


-- Task_3
-- Количество исполнителей в каждом жанре
select name, count(musician_id) from genres g
join genre_musician gm on gm.genre_id = g.genre_id
group by g.name
order by COUNT(musician_id) desc;

-- Количество треков, вошедших в альбомы 2019-2020 годов
select count(track_id) from tracks t
join albums a on a.album_id = t.album_id
where a.release between 2019 and 2020;

-- Средняя продолжительность треков по каждому альбому
select a.name, round(AVG(duration), 2) from tracks t
join albums a on a.album_id = t.album_id
group by a.name
order by round(AVG(duration), 2) desc;

-- Все исполнители, которые не выпустили альбомы в 2020 году
select distinct nickname from musicians m
join album_musician am on am.musician_id = m.musician_id
join albums a on a.album_id = am.album_id
where a.release != 2020;

-- Названия сборников, в которых присутствует конкретный исполнитель (Король и шут)
select distinct c.name from collections c
join track_collection tc on tc.collection_id = c.collection_id
join tracks t on t.track_id = tc.track_id
join albums a on a.album_id = t.album_id
join album_musician am on am.album_id = a.album_id
join musicians m on m.musician_id = am.musician_id
where m.nickname = 'Король и шут';

-- Task_4
-- Названия альбомов, в которых присутствуют исполнители более чем одного жанра
select a.name from albums a
join album_musician am on am.album_id = a.album_id
join musicians m on m.musician_id = am.musician_id
join genre_musician gm on gm.musician_id = m.musician_id
join genres g on g.genre_id = gm.genre_id
group by a.name
having count(a.album_id) > 1;

-- Наименования треков, которые не входят в сборники
select name from tracks t
left join track_collection tc on tc.track_id = t.track_id
where tc.collection_id is null;

-- Исполнитель или исполнители, написавшие самый короткий по продолжительности трек
select nickname from musicians m
join album_musician am ON am.musician_id = m.musician_id
join albums a on a.album_id = am.album_id
join tracks t on t.album_id = a.album_id
where t.duration = (select min(duration) from tracks);

-- Названия альбомов, содержащих наименьшее количество треков
select a.name from albums a
join tracks t on t.album_id = a.album_id
group by a.name
having count(t.track_id) < 4
