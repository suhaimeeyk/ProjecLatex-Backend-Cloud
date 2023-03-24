
app.get('/revealdisplayALL', jsonParser, function (req, res, next) {

    connection.query(
        'SELECT m.db_reveal_date, m.reveal_total as ผลรวมค่าปุ๋ย, c.customer_name as ชื่อ, u.users_name as ชื่อผู้ดูแล , md.reveal_sumtotal as ค่าหลังจ่าย , md.reveal_pay as ค่าที่จ่าย FROM db_reveal as m INNER JOIN db_customer as c ON m.users_id = c.customer_id INNER JOIN db_users as u ON u.users_id =  c.db_users_id INNER JOIN db_reveal_detail as md ON md.reveal_id =  m.reveal_id GROUP BY m.db_reveal_date, m.reveal_total, c.customer_name, u.users_name, md.reveal_sumtotal , md.reveal_pay ORDER BY m.db_reveal_date DESC;',
        function (err, results, fields) {
            let status = "Ok";
            if (err) {
                res.json({ status: 'error', message: err })
                return
            }
            
            // res.json({ results })
            return res.send({ error: false ,status: status, data: results })
            
        }
    );
})