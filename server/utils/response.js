const response = function(status, msg, data) {
  this.status = status;
  this.msg = msg;
  this.data = data;
};

module.exports = response;
