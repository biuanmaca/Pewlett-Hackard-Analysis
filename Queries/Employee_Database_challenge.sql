SELECT emp.emp_no,
	emp.first_name,
	emp.last_name,
	ti.title,
	ti.from_date,
	ti.to_date

INTO retirement_titles
FROM employees AS emp
INNER JOIN titles AS ti
	ON emp.emp_no = ti.emp_no
WHERE (emp.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY emp.emp_no;


-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (rt.emp_no) rt.emp_no,
	rt.first_name,
	rt.last_name,
	rt.title
	
INTO unique_titles
FROM retirement_titles AS rt
ORDER BY rt.emp_no, rt.to_date DESC;

--Retrieve Number of employees by their most recent job title who are about to retire
SELECT COUNT(title), title
--INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY count DESC;


--Determine eligibility to participate in mentorship program
SELECT DISTINCT ON (emp.emp_no) emp.emp_no,
	emp.first_name,
	emp.last_name,
	emp.birth_date,
	de.from_date,
	de.to_date,
	ti.title
	
INTO mentorship_eligibility

FROM employees AS emp
	INNER JOIN dept_emp AS de
		ON emp.emp_no = de.emp_no
	INNER JOIN titles AS ti
		ON emp.emp_no = ti.emp_no

WHERE de.to_date = '9999-01-01'
	AND (emp.birth_date BETWEEN '1965-01-01' AND '1965-12-03')
ORDER BY emp.emp_no;