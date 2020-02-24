const mongoose = require('mongoose');
const bcrypt = require('bcryptjs');
const Strings = require('../utils/strings');

const User_schema = mongoose.Schema({
  firstName: {
    type: String
  },
  lastName: {
    type: String
  },
  email: {
    type: String,
    unique: true
  },
  avatar: {
    type: String,
    default: '/vbs_data/avatar.png'
  },
  password: {
    type: String
  },
  role: {
    type: String,
    default: Strings.role.modelCreator
  },
  address: {
    type: String
  }
});

const User = mongoose.model('User', User_schema);
module.exports = User;

mongoose.set('useCreateIndex', true);

module.exports.getUserById = userId => {
  return new Promise((resolve, reject) => {
    User.findById(userId)
      .then(user => resolve(user))
      .catch(err => reject(err));
  });
};

module.exports.getUserByEmail = email => {
  return new Promise((resolve, reject) => {
    const query = { email: email };
    User.findOne(query)
      .then(user => resolve(user))
      .catch(err => reject(err));
  });
};

module.exports.getUserByUsername = username => {
  return new Promise((resolve, reject) => {
    const query = { username: username };
    User.findOne(query)
      .then(user => resolve(user))
      .catch(err => reject(err));
  });
};

module.exports.addUser = function(newUser, callback) {
  bcrypt.genSalt(10, function(err, salt) {
    bcrypt.hash(newUser.password, salt, function(err, hash) {
      if (err) {
        throw err;
      }
      newUser.password = hash;
      newUser.save(callback);
    });
  });
};

module.exports.comparePassword = function(candidatePassword, hash, callback) {
  bcrypt.compare(candidatePassword, hash, (err, isMatch) => {
    if (err) {
      throw err;
    }
    callback(null, isMatch);
  });
};
