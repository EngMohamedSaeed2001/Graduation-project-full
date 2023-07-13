import axios from 'axios';


let auth = `${localStorage.getItem("set_auth")}`
let email = `${localStorage.getItem("user_email")}`
let username = `${localStorage.getItem("user_name")}`
let token = `${localStorage.getItem("user_token")}`;


const apiToken = axios.create({
    baseURL: `http://localhost:8080/`,
    //baseURL:'https://restaurant.loca.lt'
});

apiToken.defaults.headers.post['Access-Control-Allow-Origin'] = "*"
apiToken.defaults.headers.post['Access-Control-Allow-Credentials'] = "true"
apiToken.defaults.headers.post['Access-Control-Allow-Headers'] = "DNT,X-CustomHeader,Keep-Alive,User-Agent,X-Requested-With,If-Modified-Since,Cache-Control,Content-Type,Authorization"
apiToken.defaults.headers.post['Access-Control-Allow-Methods'] = "GET,POST,PUT,DELETE,OPTIONS"
apiToken.defaults.headers.post['Authorization'] = `Bearer ` + token;
apiToken.defaults.headers.get['Authorization'] = `Bearer ` + token;
apiToken.defaults.headers.put['Authorization'] = `Bearer ` + token;
apiToken.defaults.headers.patch['Authorization'] = `Bearer ` + token;
apiToken.defaults.headers.delete['Authorization'] = `Bearer ` + token;


const api = axios.create({
    baseURL: `http://localhost:8080/`,
    // baseURL:'https://restaurant.loca.lt'
});

export default {api, apiToken, email, username, auth, token};

