
--Produce a list of the start times for bookings for tennis courts, for the date '2016-09-21'? Return a list of start time and facility name pairings, ordered by the time.

Hint: In the WHERE clause use IN. See Example IN Operator

SELECT b.start_time, f.name FROM bookings b JOIN facilities f ON f.id = b.facility_id WHERE f.name IN ('Tennis Court 1', 'Tennis Court 2') AND b.start_time between '2016-09-21' and '2016-09-21 23:59:59' ORDER BY b.start_time ASC;
;


--Produce a list of all members who have used a tennis court? Include in your output the name of the court, and the name of the member formatted as first name, surname. Ensure no duplicate data, and order by the first name.
SELECT DISTINCT  m.first_name, m.surname, f.name FROM members m JOIN bookings b ON m.id = b.member_id JOIN facilities f ON f.id = b.facility_id WHERE f.name IN ('Tennis Court 1', 'Tennis Court 2') ORDER BY m.first_name;

--Produce a number of how many times Nancy Dare has used the pool table facility?

SELECT m.first_name, m.surname, f.name, count(b.start_time) FROM members m JOIN bookings b ON m.id = b.member_id JOIN facilities f ON f.id = b.facility_id WHERE f.name IN ('Pool Table') AND m.first_name = 'Nancy' AND m.surname = 'Dare' GROUP BY m.surname, m.first_name, f.name;


--Produce a list of how many times Nancy Dare has visited each country club facility.
SELECT m.first_name, m.surname, f.name, count(b.start_time) AS times_visited FROM members m JOIN bookings b ON m.id = b.member_id JOIN facilities f ON f.id = b.facility_id WHERE m.first_name = 'Nancy' AND m.surname = 'Dare' GROUP BY f.name, m.first_name, m.surname ORDER BY times_visited DESC;

--Produce a list of all members who have recommended another member? Ensure that there are no duplicates in the list, and that results are ordered by (surname, firstname).

SELECT DISTINCT m.surname, m.first_name FROM members m JOIN members mrb ON m.id = mrb.recommended_by ORDER BY m.surname, m.first_name;

--Output a list of all members, including the individual who recommended them (if any), without using any JOINs? Ensure that there are no duplicates in the list, and that member is formatted as one column and ordered by member.

SELECT DISTINCT first_name || ' '|| surname AS member, recommended_by, (SELECT first_name || ' '|| surname FROM members WHERE recommended_by(id)) AS recommender FROM members ORDER BY member;


--SELECT DISTINCT first_name || ' '|| surname AS member, first_name || ' '|| surname AS recommender FROM members WHERE (SELECT recommended_by FROM members)

SELECT DISTINCT first_name || ' '|| surname AS member, recommended_by, (SELECT DISTINCT first_name || ' '|| surname AS recommender FROM members m WHERE id = mrb.recommended_by) FROM members mrb ORDER BY member;
