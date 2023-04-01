app.post('/Createdatadb_income', jsonParser, function (req, res, next) {

    connection.execute(
        'INSERT INTO db_income(Manuredb_income  ,Revealdb_income	,pay_for_all_latex_db_income ,total_price , note) VALUES( ? , ? , ? , ? , ?, ? )',
        [req.body.Manuredb_income	, req.body.Revealdb_income	, req.body.pay_for_all_latex_db_income	, req.body.total_price, req.body.note],
        function (err, results, fields) {
            if (err) {
                res.json({ status: 'error', message: err })
                return
            }
            res.json({ status: 'Ok' })
        }

    );

})

