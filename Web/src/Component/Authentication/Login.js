import React, {useState} from "react";
import '../../index.css';

import {Button, Col, Container, FloatingLabel, Form, Navbar, Row, Spinner} from "react-bootstrap";
import {Formik} from 'formik';
import {object, string} from 'yup';
import {Link, Navigate} from "react-router-dom";


import Social from "./Social";
import validator from "validator";
import api from "../../Apis/Base";
import ToastMsg from "../../Helper/Toast";
import {useTranslation} from "react-i18next";


const schema = object({

    email: string().required(),
    password: string().required(),
});


const Login = () => {
    let {t} = useTranslation()
    let [email, setEmail] = useState("");
    let [password, setPassword] = useState("");
    let [wait, setWait] = useState(false);
    let [wrong, setWrong] = useState(false);
    let [loadButton, setLoadButton] = useState(true);

    let [msg, setMsg] = useState("");


    const getUser = () => {
        api.apiToken.post("common/getUser", {
            email: api.email,

        }).then((res) => {
            if (res.status === 200) {
                console.log(res.data)
                if (res.data.profile.id === 3 || res.data.profile.id === 1) {
                    localStorage.setItem("is_admin", "true")
                    console.log("aa")
                }
            }

        }).catch((e) => {

            console.log(e.response.data.message)
        })
    }

    const submit = () => {

        api.api.post("insecure/authenticate", {
            email: email,
            password: password

        }).then((res) => {
            if (res.status === 200) {
                setEmail("")
                setPassword("")


                localStorage.setItem("user_token", res.data.token)
                localStorage.setItem("user_email", email)
                localStorage.setItem("set_auth", "true")
                setLoadButton(true)
                // getUser()
                setWait(true)
            }

        }).catch((e) => {

            console.log(e.response.data.message)
            setWrong(true)
            setMsg(e.response.data.message)
            setLoadButton(true)
        })
    }

    if (wait === true) {

        setTimeout(() => {
            setLoadButton(true)
        }, 1000)

      window.location.reload()
    }


    return (
        <Container fluid>
            <Formik
                validationSchema={schema}
                onSubmit={console.log}
                initialValues={{
                    email: '',
                    password: '',
                }}
            >
                {({
                      handleSubmit,
                      handleChange,
                      handleBlur,
                      values,
                      touched,
                      isValid,
                      errors,
                  }) => (

                    <Container className="login">
                        <Navbar>
                            <Navbar.Brand href="/">
                                <img src={'images/logo/logo2.png'} width={180}/>
                            </Navbar.Brand>
                        </Navbar>

                        <Row>
                            <Col lg={true}>
                                <h2 style={{
                                    marginTop: "50px",
                                    marginBottom: "30px",
                                    fontWeight: "bold"
                                }}>{t("login")}</h2>
                                <h5 style={{
                                    marginTop: "50px",
                                    marginBottom: "30px",
                                    fontWeight: "bold"
                                }}>{t("welcomeBack")}</h5>
                                <ToastMsg show={wrong} setShow={() => setWrong(false)} msg={msg}/>
                                <Form noValidate>

                                    <Row className="inputs">
                                        <FloatingLabel
                                            controlId="floatingInput"
                                            label={t("email")}
                                            className="mb-3 label"
                                        >
                                            <Form.Control type="email" placeholder="name@example.com"
                                                          name="email"
                                                          value={values.email}
                                                          onChange={handleChange}
                                                          isInvalid={!!errors.email}
                                                          className="label"
                                            />

                                            {
                                                !validator.isEmpty(values.email) &&
                                                !validator.isEmail(values.email) ? <p style={{
                                                    color: "#c7393d",
                                                    fontSize: "16px",
                                                    textAlign: "left",
                                                    marginTop: "10px"
                                                }}>It must be example@domain.com</p> : null
                                            }
                                            {setEmail(values.email)}
                                            <Form.Control.Feedback className="feedback" type="invalid" tooltip>
                                                {errors.email}
                                            </Form.Control.Feedback>

                                        </FloatingLabel>
                                    </Row>

                                    <Row className="inputs">
                                        <FloatingLabel controlId="floatingPassword" className="label"
                                                       label={t("enterPassword")}>
                                            <Form.Control
                                                type="password" placeholder={t("enterPassword")}
                                                name="password"
                                                value={values.password}
                                                onChange={handleChange}
                                                isInvalid={!!errors.password}
                                            />

                                            {
                                                !validator.isEmpty(values.password) &&
                                                values.password.length <= 6 || values.password.length >= 18 ?
                                                    <p style={{
                                                        color: "#c7393d",
                                                        fontSize: "16px",
                                                        textAlign: "left",
                                                        marginTop: "10px"
                                                    }}>{t("ItMustBeGreaterThan6AndLessThan18")}</p> : null

                                            }
                                            {setPassword(values.password)}
                                            <Form.Control.Feedback className="feedback" type="invalid" tooltip>
                                                {errors.password}
                                            </Form.Control.Feedback>
                                        </FloatingLabel>
                                    </Row>

                                    <Row className="inputs">

                                        <Button disabled={!(email.length !== 0 && password.length !== 0)}
                                                className="buttonSubmit"
                                                style={{maxWidth:"98%"}}
                                                onClick={() => {
                                                    submit();
                                                    setLoadButton(false);
                                                }}
                                        >

                                            Login
                                            {loadButton ?
                                                null
                                                :
                                                <Spinner animation="border" size={"sm"}
                                                         style={{color: "#ffffff", marginLeft: "8%"}}/>
                                            }

                                        </Button>

                                    </Row>

                                    <p style={{margin:"auto"}}><Link to={'/resetPassword'}
                                                                                             style={{
                                                                                                 textDecoration: "none",
                                                                                                 color: "#ed4e53",
                                                                                             }}>{t("forgetPassword")}</Link>
                                    </p>


                                    <Row style={{marginTop:"20px"}}>
                                        <p style={{fontSize: "20px", fontWeight: "bold"}}>OR</p>
                                        <Social login={true}/>
                                    </Row>
                                </Form>

                                <p>{t("DontHaveAccount")}<Link to={'/signup'} style={{
                                    textDecoration: "none",
                                    color: "#ed4e53"
                                }}> {t("createOne")}</Link></p>
                            </Col>
                        </Row>
                    </Container>
                )}
            </Formik>
        </Container>
    );
}

export default Login;
