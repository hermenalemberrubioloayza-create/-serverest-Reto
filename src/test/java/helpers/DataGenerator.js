function fn() {
  var uuid = java.util.UUID.randomUUID().toString().substring(0, 6);
  var timestamp = new Date().getTime();

  return {
    getRandomUser: function() {
      return {
        nome: "QA Automation " + uuid,
        email: "user_" + timestamp + "_" + uuid + "@challengeqa.com",
        password: "Secret@" + timestamp,
        administrador: "true"
      };
    }
  };
}