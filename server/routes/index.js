const express = require('express');
const jwt = require('jsonwebtoken');

const dbConnector = require('../config/dbConnector');
const Response = require('../utils/response');
const Strings = require('../utils/strings');
const User = require('../models/user');

const router = express.Router();

router.post('/authenticate', (req, res) => {
  const email = req.body.email;
  const password = req.body.password;

  User.getUserByEmail(email)
    .then(user => {
      if (!user) {
        return res
          .status(400)
          .json(
            new Response(
              Strings.responseStatus.failure,
              'There is no user with such an email, Register instead?'
            )
          );
      }

      User.comparePassword(password, user.password, (err, isMatch) => {
        if (err) {
          res
            .status(400)
            .json(
              new Response(
                Strings.responseStatus.failure,
                'Password didnt match'
              )
            );
        }
        if (isMatch) {
          const token = jwt.sign(user.toJSON(), dbConnector.secret, {
            expiresIn: 86400 // 1 day
          });
          res
            .status(200)
            .json(
              new Response(
                Strings.responseStatus.success,
                'Sign in successfully',
                `JWT ${token}`
              )
            );
        } else {
          res
            .status(400)
            .json(
              new Response(Strings.responseStatus.failure, 'Wrong password')
            );
        }
      });
    })
    .catch(err => {
      res
        .status(400)
        .json(
          new Response(
            Strings.responseStatus.failure,
            'No user with this email'
          )
        );
    });
});

router.post('/register', (req, res) => {
  const firstName = req.body.firstName;
  const lastName = req.body.lastName;
  const email = req.body.email;
  const password = req.body.password;

  const newUser = new User({
    firstName: firstName,
    lastName: lastName,
    email: email,
    password: password
  });
  User.addUser(newUser, (err, user) => {
    if (err) {
      res
        .status(400)
        .json(
          new Response(
            Strings.responseStatus.failure,
            'This email is already registered, login instead?'
          )
        );
    } else {
      res
        .status(201)
        .json(
          new Response(
            Strings.responseStatus.success,
            'Registrated successfully',
            user
          )
        );
    }
  });
});

module.exports = router;
