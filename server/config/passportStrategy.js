var JwtStrategy = require('passport-jwt').Strategy;
var ExtractJwt = require('passport-jwt').ExtractJwt;
var User = require('../models/user');
var dbConnector = require('./dbConnector');

module.exports = function(passport) {
  var opts = {};
  opts.jwtFromRequest = ExtractJwt.fromAuthHeaderWithScheme('jwt');
  opts.secretOrKey = dbConnector.secret;
  passport.use(
    new JwtStrategy(opts, (jwt_payload, done) => {
      User.getUserById(jwt_payload._id)
        .then(user => {
          if (user) {
            return done(null, user);
          } else {
            return done(null, false);
          }
        })
        .catch(err => {
          return done(err, false);
        });
    })
  );
};
