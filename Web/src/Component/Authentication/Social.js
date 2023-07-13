import '../../index.css';
import React, {useState} from 'react';
import GoogleLogin from 'react-google-login';
import {Navigate} from "react-router-dom";
import {Container, Row} from "react-bootstrap";
import api from "../../Apis/Base";
import ToastMsg from "../../Helper/Toast";

let username = ""
let email = ""
let image = ""
const Social = (props) => {
    const [redirect, setRedirect] = useState(false);
    let [username, setUsername] = useState("");
    let [email, setEmail] = useState("");
    let [token, setToken] = useState("");
    let [image, setImage] = useState("");
    let [hide, setHide] = useState(false);
    let [wrong, setWrong] = useState(false);
    let [msg, setMsg] = useState("");

    const signUp = (res, type) => {


        if (type === "google" && res.profileObj) {
            username = res.profileObj.name;
            email = res.profileObj.email;
            setToken(res.accessToken)
            image = res.profileObj.imageUrl

            if (props.login) {
                submit(email)
            } else {
                addUser(username, email, image)
            }

        }
    }

    const submit = (email) => {

        api.api.post("insecure/authenticate", {
            email: email,
            social: true

        }).then((res) => {
            if (res.status === 200) {
                setEmail("")
                setUsername("")
                localStorage.setItem("user_token", res.data.token)
                localStorage.setItem("user_email", email)
                localStorage.setItem("set_auth", "true")
                setRedirect(true);
                //setLoadButton(true)
                // getUser()

            }

        }).catch((e) => {

            console.log(e.response.data.message)
            setWrong(true)
            setMsg(e.response.data.message)
            setHide(true)
        })
    }

    const addUser = (username, email, image) => {

        api.api.post("insecure/userDetails", {
            username: username,
            email: email,
            social: true,
            img: image
        }).then((res) => {
            if (res.status === 200) {

                setEmail("")
                setUsername("")
                localStorage.setItem("user_token", res.data.token)
                localStorage.setItem("user_email", email)
                localStorage.setItem("set_auth", "true")
                setRedirect(true);
            }

        }).catch((e) => {
            console.log(e)
            setWrong(true)
            setMsg(e.response.data.message)
            setHide(true)
        })
    }

    if (redirect) {
        return <Navigate to={"/"}/>
    }


    const responseGoogle = (response) => {
        signUp(response, 'google');
    }


    return (
        <Container style={{height: "100px"}}>
            {hide ?
                <ToastMsg show={hide} setShow={() => setHide(false)}
                          msg={msg}/>
                : null
            }
            <Row style={{width: "50%", height: "50px", margin: "auto", marginTop: "20px"}}>
                <GoogleLogin
                    clientId="148396029595-rh29eiqo7m8c0tatvgefoa0rtsfdao4s.apps.googleusercontent.com"
                    buttonText="Login"
                    onSuccess={responseGoogle}
                    onFailure={responseGoogle}
                    cookiePolicy={'single_host_origin'}

                />
            </Row>

        </Container>
    );
}

export default Social;
