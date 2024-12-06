-- Retrieve tickets for a specific order number
SELECT t.order_num, t.dish_name, t.description, t.quantity, d.price
FROM ticket AS t
JOIN dish AS d ON t.dish_name = d.dish_name
WHERE t.order_num = 1;

-- List employees who are trained on dish
SELECT e.emp_id, e.first_name, e.last_name
FROM employee AS e
JOIN position AS p ON e.emp_id = p.emp_id
WHERE p.position = 'Dish';

-- Dishes ordered with expired ingrediants
SELECT 
    co.order_num,
    co.date AS order_date,
    t.dish_name,
    i.ing_name,
    i.exp_date
FROM ticket AS t
JOIN cus_order AS co ON t.order_num = co.order_num
JOIN recipe AS r ON t.dish_name = r.dish_name
JOIN ingredient AS i ON r.ing_name = i.ing_name
WHERE i.exp_date <= co.date; 

-- Show all employees who worked as Server and Host and when
SELECT 
    e.emp_id,
    e.first_name,
    e.last_name,
    GROUP_CONCAT(CASE WHEN es.cur_pos = 'Server' THEN es.shift_id END) AS server_shifts,
    GROUP_CONCAT(CASE WHEN es.cur_pos = 'Host' THEN es.shift_id END) AS cook_shifts
FROM employee AS e
JOIN emp_shift AS es ON e.emp_id = es.emp_id
GROUP BY e.emp_id, e.first_name, e.last_name
HAVING COUNT(DISTINCT CASE WHEN es.cur_pos = 'Server' THEN 1 END) > 0
   AND COUNT(DISTINCT CASE WHEN es.cur_pos = 'Host' THEN 1 END) > 0;
   
-- Show total sales and total tips per server
SELECT 
    e.first_name,
    e.last_name,
    SUM(co.order_total) AS total_sales,
    SUM(co.tip) AS total_tips
FROM cus_order AS co
JOIN employee AS e ON co.emp_id = e.emp_id
WHERE co.status = 'CLOSED'
  AND e.status = 'On Shift'
  AND e.emp_type = 'Hourly'
GROUP BY e.first_name, e.last_name;


