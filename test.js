
app.get('/ownerdisplay_detail/:owner_id', (req, res) => {
    let owner_id = req.params.owner_id;

    if (!owner_id) {
        return res.status(400).send({ error: true, message: "Please provide  owner_id" });
    } else {
        connection.query("SELECT d.owner_detail_date, d.owner_sumtotal , d.owner_pay , d.owner_total , c.customer_name FROM db_owner_detail as d INNER JOIN db_owner as m ON d.owner_id = m.owner_id INNER JOIN db_customer as c ON m.users_id = c.customer_id WHERE m.owner_id  = ?", owner_id, (error, results, fields) => {
            if (error) throw error;

            let message = "";
            let status = "Ok";
            if (results === undefined || results.length == 0) {
                message = "not found";
            } else {
                message = "Successfully data";
            }

            return res.send({ status: status, results: results, message: message })
        })
    }
})



app.get('/ownereditform/:owner_id', (req, res) => {
    let owner_id = req.params.owner_id;

    if (!owner_id) {
        return res.status(400).send({ error: true, message: "Please provide  owner_id" });
    } else {
        connection.query("SELECT m.owner_id, m.users_id,c.customer_name  , m.owner_total FROM db_owner as m INNER JOIN db_customer as c ON m.users_id = c.customer_id WHERE m.owner_id = ?", owner_id, (error, results, fields) => {
            if (error) throw error;

            let message = "";
            let status = "Ok";
            if (results === undefined || results.length == 0) {
                message = "not found";
            } else {
                message = "Successfully data";
            }

            return res.send({ status: status, data: results[0], message: message })
        })
    }
})
app.get('/ownereditformdetail/:owner_id', (req, res) => {
    let owner_id = req.params.owner_id;

    if (!owner_id) {
        return res.status(400).send({ error: true, message: "Please provide  owner_id" });
    } else {
        connection.query("SELECT d.owner_id, m.users_id, c.customer_name, d.owner_total, m.owner_total, d.owner_sumtotal, d.owner_pay, d.owner_detail_date FROM db_owner as m INNER JOIN db_customer as c ON m.users_id = c.customer_id INNER JOIN db_owner_detail as d ON m.owner_id = d.owner_id WHERE m.owner_id = ? ORDER BY d.owner_detail_date DESC LIMIT 1;", owner_id, (error, results, fields) => {
            if (error) throw error;

            let message = "";
            let status = "Ok";
            if (results === undefined || results.length == 0) {
                message = "not found";
            } else {
                message = "Successfully data";
            }

            return res.send({ status: status, data: results[0], message: message })
        })
    }
})


app.post('/editowner', jsonParser, function (req, res, next) {

    connection.execute(
        'INSERT INTO db_owner_detail(owner_id,owner_sumtotal,owner_pay,owner_total)  VALUES(  ? , ? ,  ? , ? )',
        [req.body.owner_id, req.body.owner_sumtotal, req.body.owner_pay, req.body.owner_total],
        function (err, results, fields) {
            if (err) {
                res.json({ status: 'error', message: err })
                return
            }
            res.json({ status: 'Ok' })
        }

    );

})

app.delete('/db_owner_id', jsonParser, function (req, res, next) {

    connection.execute(
        'DELETE FROM db_owner WHERE owner_id = ?',
        [req.body.owner_id],
        function (err, results, fields) {

            if (err) {
                res.json({ status: 'error', message: err })
                return
            }
            // res.json({results})
            res.json({ status: 'Ok' })
        }
    );
})