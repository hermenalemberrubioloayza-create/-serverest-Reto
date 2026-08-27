function fn() {
  var config = {
    baseUrl: 'https://serverest.dev',
    getRandomUser: function() {
      var uuid = java.util.UUID.randomUUID().toString().substring(0, 6);
      var timestamp = new Date().getTime();
      return {
        nome: "QA User " + uuid,
        email: "user_" + timestamp + "_" + uuid + "@challengeqa.com",
        password: "Pass@" + timestamp,
        administrador: "true"
      };
    }
  };

  karate.configure('connectTimeout', 10000);
  karate.configure('readTimeout', 10000);

  return config;
}