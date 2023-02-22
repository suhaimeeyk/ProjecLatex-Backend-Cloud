var express = require('express')
var cors = require('cors')
var app = express()
var bodyParser = require('body-parser')
var jsonParser = bodyParser.json()

const bcrypt = require('bcrypt')
const saltRounds = 10

var jwt = require('jsonwebtoken')
const secret = 'Login-React';

app.use(cors())

const mysql = require('mysql2');
// create the connection to database
const connection = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: 'root',
    database: 'therubber2',
    port: 3306
});


app.post('/register', jsonParser, function (req, res, next) {
    bcrypt.hash(req.body.users_password, saltRounds, function (err, hash) {

        connection.execute(
            'INSERT INTO db_users (users_usersname,users_password,users_name,users_tel,level) VALUES (?,?,?,?,?)',
            [req.body.users_usersname, hash, req.body.users_name, req.body.users_tel, req.body.level],
            function (err, results, fields) {
                if (err) {
                    res.json({ status: 'error', message: err })
                    return
                }
                res.json({ status: 'Ok' })
            }
        );
    });
})

app.post('/login', jsonParser, function (req, res, next) {
    connection.execute(
        'SELECT * FROM db_users WHERE users_usersname=?',
        [req.body.users_usersname],
        function (err, users, fields) {
            if (err) { res.json({ status: 'error', message: err }); return }
            if (users.length == 0) { res.json({ status: 'error', message: 'no user found' }); return }
            bcrypt.compare(req.body.users_password, users[0].users_password, function (err, isLogin) {

                if (isLogin) {
                    var token = jwt.sign( { users_name: users[0].users_name, users_id: users[0].users_id }, secret, { expiresIn: '1h' });
                    res.json({ status: 'ok', message: 'Login success' , level: users[0].level , token})
                } else {
                    res.json({ status: 'error', message: 'Login failed' })
                }
            });
        }
    );

})


app.post('/authen', jsonParser, function (req, res, next) {


    try {
        const token = req.headers.authorization.split(' ')[1]            

        var decoded = jwt.verify(token, secret);
        res.json({ status: 'ok', decoded })
    } catch (err) {

        res.json({ status: 'error', message: err.message})
    }


})



app.get('/Users', jsonParser, function (req, res, next) {

    connection.execute(
        'SELECT * FROM db_users,db_level where db_level.id = db_users.level ',
        function (err, results, fields) {
            if (err) {
                res.json({ status: 'error', message: err })
                return
            }
            res.json({ results })
        }
    );
})

app.get('/db_level', jsonParser, function (req, res, next) {

    connection.execute(
        'SELECT * FROM db_level ',
        function (err, results, fields) {
            if (err) {
                res.json({ status: 'error', message: err })
                return
            }
            res.json({ results })
        }
    );
})

app.get('/EditUser/:users_id', (req, res) => {
    let users_id = req.params.users_id;

    if (!users_id) {
        return res.status(400).send({ error: true, message: "Please provide  users_id" });
    } else {
        connection.query("SELECT * FROM  db_users WHERE users_id = ?", users_id, (error, results, fields) => {
            if (error) throw error;

            let message = "";
            let status = "Ok";
            if (results === undefined || results.length == 0) {
                message = "Book not found";
            } else {
                message = "Successfully data";
            }

            return res.send({ status: status, data: results[0], message: message })
        })
    }
})


app.put('/EditUser', jsonParser, function (req, res, next) {
    bcrypt.hash(req.body.users_password, saltRounds, function (err, hash) {

        connection.query(
            ' UPDATE db_users SET users_usersname = ?, users_password = ?, users_name = ?, users_tel = ? , level = ? WHERE users_id = ?',
            [req.body.users_usersname, hash, req.body.users_name, req.body.users_tel , req.body.level, req.body.users_id],
            function (err, results, fields) {
                let status = "Ok";
                let message = "";
                if (results.changedRows === 0) {
                    message = "Book not found or data are same";
                } else {
                    message = "successfully updated";
                }

                return res.send({ status: status, error: false, data: results, message: message })

            }
        );
    });
})




app.delete('/Users_id', jsonParser, function (req, res, next) {

    connection.execute(
        'DELETE FROM db_users WHERE users_id = ?',
        [req.body.users_id],
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

// ประเภทสมาชิก

app.post('/Createdb_catusers', jsonParser, function (req, res, next) {
    bcrypt.hash(req.body.users_password, saltRounds, function (err, hash) {

        connection.execute(
            'INSERT INTO db_catusers (catusers_name) VALUES (?)',
            [req.body.catusers_name],
            function (err, results, fields) {
                if (err) {
                    res.json({ status: 'error', message: err })
                    return
                }
                res.json({ status: 'Ok' })
            }
        );
    });
})

app.get('/db_catusers', jsonParser, function (req, res, next) {

    connection.execute(
        'SELECT * FROM db_catusers',
        function (err, results, fields) {
            if (err) {
                res.json({ status: 'error', message: err })
                return
            }
            res.json({ results })
        }
    );
})

app.delete('/db_catusers_id', jsonParser, function (req, res, next) {

    connection.execute(
        'DELETE FROM db_catusers WHERE catusers_id = ?',
        [req.body.catusers_id],
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


app.get('/EditUserdb_catusers/:catusers_id', (req, res) => {
    let catusers_id = req.params.catusers_id;

    if (!catusers_id) {
        return res.status(400).send({ error: true, message: "Please provide  catusers_id" });
    } else {
        connection.query("SELECT * FROM  db_catusers WHERE catusers_id = ?", catusers_id, (error, results, fields) => {
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


app.put('/EditUserdb_catusers', jsonParser, function (req, res, next) {
    bcrypt.hash(req.body.users_password, saltRounds, function (err, hash) {

        connection.query(
            ' UPDATE db_catusers SET catusers_name = ? WHERE catusers_id = ?',
            [req.body.catusers_name, req.body.catusers_id],
            function (err, results, fields) {
                let status = "Ok";
                let message = "";
                if (results.changedRows === 0) {
                    message = " not found or data are same";
                } else {
                    message = "successfully updated";
                }

                return res.send({ status: status, error: false, data: results, message: message })

            }
        );
    });
})


// ประเภทการเบิก

app.post('/Createdb_catwithdraw', jsonParser, function (req, res, next) {

    connection.execute(
        'INSERT INTO db_catwithdraw (catwithdraw_name) VALUES (?)',
        [req.body.catwithdraw_name],
        function (err, results, fields) {
            if (err) {
                res.json({ status: 'error', message: err })
                return
            }
            res.json({ status: 'Ok' })
        }
    );

})

app.get('/db_catwithdraw', jsonParser, function (req, res, next) {

    connection.execute(
        'SELECT * FROM db_catwithdraw',
        function (err, results, fields) {
            if (err) {
                res.json({ status: 'error', message: err })
                return
            }
            res.json({ results })
        }
    );
})

app.delete('/db_catwithdraw_id', jsonParser, function (req, res, next) {

    connection.execute(
        'DELETE FROM db_catwithdraw WHERE catwithdraw_id = ?',
        [req.body.catwithdraw_id],
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

app.get('/EditUserdb_catwithdraw/:catwithdraw_id', (req, res) => {
    let catwithdraw_id = req.params.catwithdraw_id;

    if (!catwithdraw_id) {
        return res.status(400).send({ error: true, message: "Please provide  catwithdraw_id" });
    } else {
        connection.query("SELECT * FROM  db_catwithdraw WHERE catwithdraw_id = ?", catwithdraw_id, (error, results, fields) => {
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


app.put('/EditUserdb_catwithdraw', jsonParser, function (req, res, next) {
    bcrypt.hash(req.body.users_password, saltRounds, function (err, hash) {

        connection.query(
            ' UPDATE db_catwithdraw SET catwithdraw_name = ? WHERE catwithdraw_id = ?',
            [req.body.catwithdraw_name, req.body.catwithdraw_id],
            function (err, results, fields) {
                let status = "Ok";
                let message = "";
                if (results.changedRows === 0) {
                    message = " not found or data are same";
                } else {
                    message = "successfully updated";
                }

                return res.send({ status: status, error: false, data: results, message: message })

            }
        );
    });
})


// ราคาน้ำยางแต่ละวัน

app.post('/Createdb_pricerubbers', jsonParser, function (req, res, next) {


    connection.execute(
        'INSERT INTO db_pricerubbers (  percent , price ) VALUES (?,?)',
        [ req.body.percent, req.body.price],
        function (err, results, fields) {
            if (err) {
                res.json({ status: 'error', message: err })
                return
            }
            res.json({ status: 'Ok' })
        }
    );

})

app.get('/db_pricerubbers', jsonParser, function (req, res, next) {

    
    
    connection.query(
        'SELECT * FROM db_pricerubbers ORDER BY DATE(date_create)DESC , date_create ASC',
        function (err, results, fields) {
        
            // const formattedDate = `${myDate.getDate() + 1}/${myDate.getMonth() + 1}/${myDate.getFullYear()}`;
            // var results.date_create = new FormData(formattedDate);
            
            if (err) {
                res.json({ status: 'error', message: err })
                return
            }
            
            // res.json({ results })
            return res.send({ error: false , results: results })
            
        }
    );
})

app.get('/db_pricerubbersSelect', jsonParser, function (req, res, next) {

    
    
    connection.query(
        'SELECT * FROM db_pricerubbers ORDER BY  price ASC',
        function (err, results, fields) {
        
            // const formattedDate = `${myDate.getDate() + 1}/${myDate.getMonth() + 1}/${myDate.getFullYear()}`;
            // var results.date_create = new FormData(formattedDate);
            
            if (err) {
                res.json({ status: 'error', message: err })
                return
            }
            
            // res.json({ results })
            return res.send({ error: false , results: results })
            
        }
    );
})

app.delete('/db_pricerubbers_id', jsonParser, function (req, res, next) {

    connection.execute(
        'DELETE FROM db_pricerubbers WHERE pricerubbers_id = ?',
        [req.body.pricerubbers_id],
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

app.get('/EditUserdb_pricerubbers/:pricerubbers_id', (req, res) => {
    let pricerubbers_id = req.params.pricerubbers_id;

    if (!pricerubbers_id) {
        return res.status(400).send({ error: true, message: "Please provide  pricerubbers_id" });
    } else {
        connection.query("SELECT * FROM  db_pricerubbers WHERE pricerubbers_id = ?", pricerubbers_id, (error, results, fields) => {
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


app.put('/EditUserdb_pricerubbers', jsonParser, function (req, res, next) {
    bcrypt.hash(req.body.users_password, saltRounds, function (err, hash) {

        connection.query(
            ' UPDATE db_pricerubbers SET  percent = ?,price = ? WHERE pricerubbers_id = ?',
            [ req.body.percent, req.body.price, req.body.pricerubbers_id],
            function (err, results, fields) {
                let status = "Ok";
                let message = "";
                if (results.changedRows === 0) {
                    message = " not found or data are same";
                } else {
                    message = "successfully updated";
                }

                return res.send({ status: status, error: false, data: results, message: message })

            }
        );
    });
})
// รายการสมาชิกลูกค้า
app.get('/db_customer', jsonParser, function (req, res, next) {

    
    
    connection.query(
        'SELECT * FROM db_customer,db_catusers,db_users where db_catusers.catusers_id = db_customer.catcustomer_id and db_users.users_id = db_customer.db_users_id',
        function (err, results, fields) {
        
            // const formattedDate = `${myDate.getDate() + 1}/${myDate.getMonth() + 1}/${myDate.getFullYear()}`;
            // var results.date_create = new FormData(formattedDate);
            let status = "Ok";
            if (err) {
                res.json({ status: 'error', message: err })
                return
            }
            
            // res.json({ results })
            return res.send({ error: false ,status: status, results: results })
            
        }
    );
})

app.post('/Createdb_customer', jsonParser, function (req, res, next) {


    connection.execute(
        'INSERT INTO db_customer (  customer_name , customer_tel , catcustomer_id , db_users_id ) VALUES (?,?,?,?)',
        [ req.body.customer_name, req.body.customer_tel,req.body.catcustomer_id, req.body.db_users_id],
        function (err, results, fields) {
            if (err) {
                res.json({ status: 'error', message: err })
                return
            }
            res.json({ status: 'Ok' })
        }
    );

})

app.get('/EditUserdb_customer/:customer_id', (req, res) => {
    let customer_id = req.params.customer_id;

    if (!customer_id) {
        return res.status(400).send({ error: true, message: "Please provide  customer_id" });
    } else {
        connection.query("SELECT * FROM  db_customer WHERE customer_id = ?", customer_id, (error, results, fields) => {
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


app.put('/EditUserdb_data', jsonParser, function (req, res, next) {
    bcrypt.hash(req.body.users_password, saltRounds, function (err, hash) {

        connection.query(
            ' UPDATE db_data SET  data_usersid = ?, cat_id = ?,data_totalgallon = ?,data_wgallon = ?,data_disgallon = ?,data_dryrubber = ?,data_price = ?,data_pricetotal = ? WHERE data_id = ?',
            [ req.body.data_usersid, req.body.cat_id , req.body.data_totalgallon , req.body.data_wgallon , req.body.data_disgallon, req.body.data_dryrubber , req.body.data_price , req.body.data_pricetotal, req.body.data_id ] ,
            function (err, results, fields) {
                let status = "Ok";
                let message = "";
                if (results.changedRows === 0) {
                    message = " not found or data are same";
                } else {
                    message = "successfully updated";
                }

                return res.send({ status: status, error: false, data: results, message: message })

            }
        );
    });
})

app.delete('/db_customer_id', jsonParser, function (req, res, next) {

    connection.execute(
        'DELETE FROM db_customer WHERE customer_id = ?',
        [req.body.customer_id],
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

// รายการสมาชิกลูกค้ารายคน

app.get('/db_customer_user/:users_id', (req, res) => {
    let db_users_id = req.params.users_id;

    if (!db_users_id) {
        return res.status(400).send({ error: true, message: "Please provide  db_users_id" });
    } else {
        connection.query("SELECT * FROM db_customer,db_catusers,db_users where db_catusers.catusers_id = db_customer.catcustomer_id and db_users.users_id = db_customer.db_users_id and db_users_id= ? " , db_users_id, (error, results, fields) => {
            if (error) throw error;

            let message = "";
            let status = "Ok";
            if (results === undefined || results.length == 0) {
                message = "not found";
            } else {
                message = "Successfully data";
            }

            return res.send({ status: status, data: results, message: message })
        })
    }
})
app.get('/UsersTo/:users_id', (req, res) => {
    let users_id = req.params.users_id;

    if (!users_id) {
        return res.status(400).send({ error: true, message: "Please provide  users_id" });
    } else {
        connection.query("SELECT * FROM db_users,db_level where db_level.id = db_users.level and users_id = ? " , users_id, (error, results, fields) => {
            if (error) throw error;

            let message = "";
            let status = "Ok";
            if (results === undefined || results.length == 0) {
                message = "not found";
            } else {
                message = "Successfully data";
            }

            return res.send({ status: status, data: results, message: message })
        })
    }
})


// รายการขายน้ำยางแต่ละคน
// app.get('/db_data', jsonParser, function (req, res, next) {

//     connection.query(
//         'SELECT * FROM db_data,db_customer,db_catwithdraw,db_users where db_catwithdraw.catwithdraw_id=db_data.cat_id and data_usersid=db_customer.customer_id and db_users_id=db_users.users_id',
//         function (err, results, fields) {
        
//             // const formattedDate = `${myDate.getDate() + 1}/${myDate.getMonth() + 1}/${myDate.getFullYear()}`;
//             // var results.date_create = new FormData(formattedDate);
//             let status = "Ok";
//             if (err) {
//                 res.json({ status: 'error', message: err })
//                 return
//             }
            
//             // res.json({ results })
//             return res.send({ error: false ,status: status, results: results })
            
//         }
//     );
// })

app.get('/db_data/:users_id', (req, res) => {
    let db_users_id = req.params.users_id;

    if (!db_users_id) {
        return res.status(400).send({ error: true, message: "Please provide  db_users_id" });
    } else {
        connection.query("SELECT * FROM db_data,db_customer,db_catwithdraw,db_users where db_catwithdraw.catwithdraw_id=db_data.cat_id and data_usersid=db_customer.customer_id and db_users_id=db_users.users_id and db_users_id= ? " , db_users_id, (error, results, fields) => {
            if (error) throw error;

            let message = "";
            let status = "Ok";
            if (results === undefined || results.length == 0) {
                message = "not found";
            } else {
                message = "Successfully data";
            }

            return res.send({ status: status, data: results, message: message })
        })
    }
})

app.get('/db_dataSelect/:users_id', (req, res) => {
    let db_users_id = req.params.users_id;

    if (!db_users_id) {
        return res.status(400).send({ error: true, message: "Please provide  db_users_id" });
    } else {
        connection.query("SELECT DISTINCT db_customer.customer_id,db_customer.customer_name  FROM db_customer,db_users  where db_users_id=db_users.users_id and db_users_id= ?" , db_users_id, (error, results, fields) => {
            if (error) throw error;

            let message = "";
            let status = "Ok";
            if (results === undefined || results.length == 0) {
                message = "not found";
            } else {
                message = "Successfully data";
            }

            return res.send({ status: status, data: results, message: message })
        })
    }
})


app.post('/Createdatadisplay', jsonParser, function (req, res, next) {

    connection.execute(
        'INSERT INTO db_data(data_usersid,cat_id,data_totalgallon,data_wgallon,data_disgallon,data_dryrubber,data_price,data_pricetotal,data_percent,data_shareprice,data_depositprice , status_id) VALUES( ? , ? , ? , ? , ? , ? , ? , ? , ? , ? , ? , ?)',
        [ req.body.data_usersid, req.body.cat_id , req.body.data_totalgallon , req.body.data_wgallon , req.body.data_disgallon, req.body.data_dryrubber , req.body.data_price , req.body.data_pricetotal , req.body.data_percent , req.body.data_shareprice, req.body.data_shareprice , req.body.status_id] ,
        function (err, results, fields) {
            if (err) {
                res.json({ status: 'error', message: err })
                return
            }
            res.json({ status: 'Ok' })
        }

    );

})


app.get('/Editdb_data/:data_id', (req, res) => {
    let data_id = req.params.data_id;

    if (!data_id) {
        return res.status(400).send({ error: true, message: "Please provide  data_id" });
    } else {
        connection.query("SELECT * FROM db_data,db_customer,db_catwithdraw,db_users where db_catwithdraw.catwithdraw_id=db_data.cat_id and data_usersid=db_customer.customer_id and db_users_id=db_users.users_id and  data_id = ?", data_id, (error, results, fields) => {
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


app.put('/EditUserdb_data', jsonParser, function (req, res, next) {
    bcrypt.hash(req.body.users_password, saltRounds, function (err, hash) {

        connection.query(
            ' UPDATE db_data SET  data_usersid = ?, cat_id = ?,data_totalgallon = ?,data_wgallon = ?,data_disgallon = ?,data_dryrubber = ?,data_price = ?,data_pricetotal = ?',
            [ req.body.data_usersid, req.body.cat_id , req.body.data_totalgallon , req.body.data_wgallon , req.body.data_disgallon, req.body.data_dryrubber , req.body.data_price , req.body.data_pricetotal ] ,
            function (err, results, fields) {
                let status = "Ok";
                let message = "";
                if (results.changedRows === 0) {
                    message = " not found or data are same";
                } else {
                    message = "successfully updated";
                }

                return res.send({ status: status, error: false, data: results, message: message })

            }
        );
    });
})


app.delete('/db_data_id', jsonParser, function (req, res, next) {

    connection.execute(
        'DELETE FROM db_data WHERE data_id = ?',
        [req.body.data_id],
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

app.put('/Editdb_data2', jsonParser, function (req, res, next) {
    bcrypt.hash(req.body.users_password, saltRounds, function (err, hash) {

        connection.query(
            ' UPDATE db_data SET data_shareprice = ?, data_depositprice = ?, status_id = ? WHERE data_id = ?',
            [req.body.data_shareprice,req.body.data_depositprice,req.body.status_id, req.body.data_id],
            function (err, results, fields) {
                let status = "Ok";
                let message = "";
                if (results.changedRows === 0) {
                    message = " not found or data are same";
                } else {
                    message = "successfully updated";
                }

                return res.send({ status: status, error: false, data: results, message: message })

            }
        );
    });
})


//ค่าปุ่ย
// app.get('/manuredisplay', jsonParser, function (req, res, next) {

//     connection.query(
//         'SELECT m.manure_id, m.users_id, c.customer_name, MAX(d.manure_detail_date) AS latest_date, SUM(d.manure_total) AS manure_total_sum, d.manure_sumtotal, d.manure_pay FROM db_manure m INNER JOIN db_customer c ON m.users_id = c.customer_id INNER JOIN (SELECT manure_id, MAX(manure_detail_date) AS latest_date FROM db_manure_detail GROUP BY manure_id) latest_dates ON m.manure_id = latest_dates.manure_id INNER JOIN db_manure_detail d ON m.manure_id = d.manure_id AND d.manure_detail_date = latest_dates.latest_date GROUP BY m.manure_id, m.users_id, c.customer_name, d.manure_sumtotal, d.manure_pay',
//         function (err, results, fields) {
//             let status = "Ok";
//             if (err) {
//                 res.json({ status: 'error', message: err })
//                 return
//             }
            
//             // res.json({ results })
//             return res.send({ error: false ,status: status, results: results })
            
//         }
//     );
// })
// app.get('/manuredisplay', jsonParser, function (req, res, next) {

//     connection.query(
//         'SELECT m.manure_total,c.customer_name,c.customer_id,m.manure_id FROM db_manure as m INNER JOIN db_customer as c ON m.users_id = c.customer_id;',
//         function (err, results, fields) {
//             let status = "Ok";
//             if (err) {
//                 res.json({ status: 'error', message: err })
//                 return
//             }
            
//             // res.json({ results })
//             return res.send({ error: false ,status: status, results: results })
            
//         }
//     );
// })
app.get('/manuredisplay/:users_id', (req, res) => {
    let users_id = req.params.users_id;

    if (!users_id) {
        return res.status(400).send({ error: true, message: "Please provide  users_id" });
    } else {
        connection.query("SELECT m.db_manure_date,m.manure_total,c.customer_name,c.customer_id,m.manure_id FROM db_manure as m INNER JOIN db_customer as c ON m.users_id = c.customer_id WHERE db_users_id = ?", users_id, (error, results, fields) => {
            if (error) throw error;

            let message = "";
            let status = "Ok";
            if (results === undefined || results.length == 0) {
                message = "not found";
            } else {
                message = "Successfully data";
            }

            return res.send({ status: status, results: results , message: message })
        })
    }
})


app.post('/CreateManuredisplay', jsonParser, function (req, res, next) {

    connection.execute(
        'INSERT INTO db_manure(users_id,manure_total) VALUES( ? , ?)',
        [ req.body.users_id, req.body.manure_total] ,
        function (err, results, fields) {
            if (err) {
                res.json({ status: 'error', message: err })
                return
            }
            res.json({ status: 'Ok' })
        }

    );

})




app.get('/manuredisplay_detail/:manure_id', (req, res) => {
    let manure_id = req.params.manure_id;

    if (!manure_id) {
        return res.status(400).send({ error: true, message: "Please provide  manure_id" });
    } else {
        connection.query("SELECT d.manure_detail_date, d.manure_sumtotal , d.manure_pay , d.manure_total , c.customer_name FROM db_manure_detail as d INNER JOIN db_manure as m ON d.manure_id = m.manure_id INNER JOIN db_customer as c ON m.users_id = c.customer_id WHERE m.manure_id  = ?", manure_id, (error, results, fields) => {
            if (error) throw error;

            let message = "";
            let status = "Ok";
            if (results === undefined || results.length == 0) {
                message = "not found";
            } else {
                message = "Successfully data";
            }

            return res.send({ status: status, results: results , message: message })
        })
    }
})



app.get('/Manureeditform/:manure_id', (req, res) => {
    let manure_id = req.params.manure_id;

    if (!manure_id) {
        return res.status(400).send({ error: true, message: "Please provide  manure_id" });
    } else {
        connection.query("SELECT m.manure_id, m.users_id,c.customer_name  , m.manure_total FROM db_manure as m INNER JOIN db_customer as c ON m.users_id = c.customer_id WHERE m.manure_id = ?", manure_id, (error, results, fields) => {
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
app.get('/Manureeditformdetail/:manure_id', (req, res) => {
    let manure_id = req.params.manure_id;

    if (!manure_id) {
        return res.status(400).send({ error: true, message: "Please provide  manure_id" });
    } else {
        connection.query("SELECT d.manure_id, m.users_id, c.customer_name, d.manure_total, m.manure_total, d.manure_sumtotal, d.manure_pay, d.manure_detail_date FROM db_manure as m INNER JOIN db_customer as c ON m.users_id = c.customer_id INNER JOIN db_manure_detail as d ON m.manure_id = d.manure_id WHERE m.manure_id = ? ORDER BY d.manure_detail_date DESC LIMIT 1;", manure_id, (error, results, fields) => {
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


app.post('/editmanure', jsonParser, function (req, res, next) {

    connection.execute(
        'INSERT INTO db_manure_detail(manure_id,manure_sumtotal,manure_pay,manure_total)  VALUES(  ? , ? ,  ? , ? )',
        [ req.body.manure_id , req.body.manure_sumtotal  , req.body.manure_pay , req.body.manure_total] ,
        function (err, results, fields) {
            if (err) {
                res.json({ status: 'error', message: err })
                return
            }
            res.json({ status: 'Ok' })
        }

    );

})

app.delete('/db_manure_id', jsonParser, function (req, res, next) {

    connection.execute(
        'DELETE FROM db_manure WHERE manure_id = ?',
        [req.body.manure_id],
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


//รายการเบิก/จ่าย

app.get('/Revealdisplay', jsonParser, function (req, res, next) {

    connection.query(
        'SELECT * FROM db_reveal,db_customer where  db_reveal.users_id=db_customer.customer_id',
        function (err, results, fields) {
            let status = "Ok";
            if (err) {
                res.json({ status: 'error', message: err })
                return
            }
            
            // res.json({ results })
            return res.send({ error: false ,status: status, results: results })
            
        }
    );
})

app.get('/Revealdisplay/:users_id', (req, res) => {
    let users_id = req.params.users_id;

    if (!users_id) {
        return res.status(400).send({ error: true, message: "Please provide  users_id" });
    } else {
        connection.query("SELECT c.customer_name,r.reveal_total, r.db_reveal_date FROM db_reveal as r INNER JOIN db_customer as c ON r.users_id = c.customer_id WHERE db_users_id = ?;", users_id, (error, results, fields) => {
            if (error) throw error;

            let message = "";
            let status = "Ok";
            if (results === undefined || results.length == 0) {
                message = "not found";
            } else {
                message = "Successfully data";
            }

            return res.send({ status: status, results: results , message: message })
        })
    }
})

app.post('/CreateRevealdisplay', jsonParser, function (req, res, next) {

    connection.execute(
        'INSERT INTO db_reveal(users_id,reveal_total) VALUES( ? , ? )',
        [ req.body.users_id, req.body.reveal_total] ,
        function (err, results, fields) {
            if (err) {
                res.json({ status: 'error', message: err })
                return
            }
            res.json({ status: 'Ok' })
        }

    );

})


app.get('/Revealdisplay_detail/:reveal_id', (req, res) => {
    let reveal_id = req.params.reveal_id;

    if (!reveal_id) {
        return res.status(400).send({ error: true, message: "Please provide  reveal_id" });
    } else {
        connection.query("SELECT d.reveal_detail_date, d.reveal_sumtotal , d.reveal_pay , d.reveal_total , c.customer_name FROM db_reveal_detail as d INNER JOIN db_reveal as m ON d.reveal_id = m.reveal_id INNER JOIN db_customer as c ON m.users_id = c.customer_id WHERE m.reveal_id  = ?", reveal_id, (error, results, fields) => {
            if (error) throw error;

            let message = "";
            let status = "Ok";
            if (results === undefined || results.length == 0) {
                message = "not found";
            } else {
                message = "Successfully data";
            }

            return res.send({ status: status, results: results , message: message })
        })
    }
})

app.get('/Revealdisplaydetail/:reveal_id', (req, res) => {
    let reveal_id = req.params.reveal_id;

    if (!reveal_id) {
        return res.status(400).send({ error: true, message: "Please provide  reveal_id" });
    } else {
        connection.query("SELECT d.reveal_id, m.users_id, c.customer_name, d.reveal_total, m.reveal_total, d.reveal_sumtotal, d.reveal_pay, d.reveal_detail_date FROM db_reveal as m INNER JOIN db_customer as c ON m.users_id = c.customer_id INNER JOIN db_reveal_detail as d ON m.reveal_id = d.reveal_id WHERE m.reveal_id = ? ORDER BY d.reveal_detail_date DESC LIMIT 1", reveal_id, (error, results, fields) => {
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


app.get('/Revealditform/:reveal_id', (req, res) => {
    let reveal_id = req.params.reveal_id;

    if (!reveal_id) {
        return res.status(400).send({ error: true, message: "Please provide  reveal_id" });
    } else {
        connection.query("SELECT m.reveal_id, m.users_id,c.customer_name  , m.reveal_total FROM db_reveal as m INNER JOIN db_customer as c ON m.users_id = c.customer_id WHERE m.reveal_id = ?", reveal_id, (error, results, fields) => {
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
app.get('/Revealditformdetail/:reveal_id', (req, res) => {
    let reveal_id = req.params.reveal_id;

    if (!reveal_id) {
        return res.status(400).send({ error: true, message: "Please provide  reveal_id" });
    } else {
        connection.query("SELECT d.reveal_id, m.users_id, c.customer_name, d.reveal_total, m.reveal_total, d.reveal_sumtotal, d.reveal_pay, d.reveal_detail_date FROM db_reveal as m INNER JOIN db_customer as c ON m.users_id = c.customer_id INNER JOIN db_reveal_detail as d ON m.reveal_id = d.reveal_id WHERE m.reveal_id = ? ORDER BY d.reveal_detail_date DESC LIMIT 1;", reveal_id, (error, results, fields) => {
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


app.listen(3333, function () {
    console.log('CORS-enabled web server listening on port 3333')
})