app.get('/ownerdisplayCostomerOwner/:users_id', (req, res) => {
    let users_id = req.params.users_id;

    if (!users_id) {
        return res.status(400).send({ error: true, message: "Please provide  users_id" });
    } else {
        connection.query("SELECT m.db_owner_date,m.owner_total,c.customer_name,c.customer_id,m.owner_id FROM db_owner as m INNER JOIN db_customer as c ON m.users_id = c.customer_id WHERE c.customer_id = ?", users_id, (error, results, fields) => {
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