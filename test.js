app.post('/editreveal', jsonParser, function (req, res, next) {

    connection.execute(
        'INSERT INTO db_reveal_detail(reveal_id,reveal_sumtotal,reveal_pay,reveal_total)  VALUES(  ? , ? ,  ? , ? )',
        [ req.body.reveal_id , req.body.reveal_sumtotal  , req.body.reveal_pay , req.body.reveal_total] ,
        function (err, results, fields) {
            if (err) {
                res.json({ status: 'error', message: err })
                return
            }
            res.json({ status: 'Ok' })
        }

    );

})