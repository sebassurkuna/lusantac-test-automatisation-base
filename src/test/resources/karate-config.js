function fn() {
  var env = karate.env || 'local';
  
  // Configuración base para todos los entornos
  var config = {
    baseUrl: 'http://localhost:8080'
  };
  
  // URLs para todos los microservicios
  config.port_marvel_api = 'http://bp-se-test-cabcd9b246a5.herokuapp.com/lusantac/api';
  
  // Configuración específica por entorno
  if (env == 'dev') {
    config.port_marvel_api = 'http://bp-se-test-cabcd9b246a5.herokuapp.com/lusantac/api';
  } 
  else if (env == 'qa') {
    config.port_marvel_api = 'http://bp-se-test-cabcd9b246a5.herokuapp.com/lusantac/api';
  }
  
  return config;
}
