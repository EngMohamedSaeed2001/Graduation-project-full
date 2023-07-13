import React, {useState} from "react";
import '../../index.css';

import {Button, Col, Container, FloatingLabel, Form, Navbar, Row, Spinner} from "react-bootstrap";
import {Formik} from 'formik';
import {object, string} from 'yup';
import ReCAPTCHA from "react-google-recaptcha";
import {Link, Navigate} from "react-router-dom";
import Social from "./Social";
import validator from "validator";
import api from "../../Apis/Base";
import ToastMsg from "../../Helper/Toast";
import {useTranslation} from "react-i18next";

const schema = object({

    email: string().required(),
    username: string().required(),
    password: string().required(),
});


const SignUp = () => {
    let {t} = useTranslation()
    let [username, setUsername] = useState("");
    let [email, setEmail] = useState("");
    let [done, setDone] = useState(true);
    let [loadButton, setLoadButton] = useState(true);
    let [wait, setWait] = useState(false);
    let [wrong, setWrong] = useState(false);
    let [msg, setMsg] = useState("");


    function checkEmail() {
        api.api.get(`insecure/userDetails/checkEmail/${email}`).then((res) => {
            if (res.status === 200) {
                setWait(true);
                setEmail("")
                setDone(false)
                localStorage.setItem("user_email", email)
            }

        }).catch((e) => {

            setWrong(true)
            setMsg(e.response.data.message)
            setLoadButton(true)
        })
    }

    if (wait) {
        return <Navigate to={'/wait'}/>
    }

    return (
        <Container fluid>
            <Formik
                validationSchema={schema}
                onSubmit={console.log}
                initialValues={{
                    username: "",
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

                    <Container className="signup">
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
                                }}>{t("signup")}</h2>
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
                                        <ReCAPTCHA
                                            sitekey="6LeIxAcTAAAAAJcZVRqyHh71UMIEGNQ_MXjiZKhI"
                                            onChange={() => {
                                                setDone(false);
                                            }}
                                        />
                                    </Row>

                                    <Row className="inputs">

                                        <Button disabled={done || !(email.length !== 0)}
                                                className="buttonSubmit"
                                                style={{maxWidth:"98%"}}
                                                onClick={() => {
                                                    checkEmail();

                                                    setLoadButton(false);

                                                }}>

                                            {t("next")}
                                            {loadButton ?
                                                null
                                                :
                                                <Spinner animation="border" size={"sm"}
                                                         style={{color: "#ffffff", marginLeft: "8%"}}/>
                                            }

                                        </Button>

                                    </Row>


                                    <Row>
                                        <p style={{fontSize: "20px", fontWeight: "bold"}}>OR</p>
                                        <Social login={false}/>
                                    </Row>
                                </Form>

                                <p>{t("alreadyHaveAccount")}<Link to={'/login'} style={{
                                    textDecoration: "none",
                                    color: "#ed4e53"
                                }}> {t("login")}</Link></p>
                            </Col>
                        </Row>
                    </Container>
                )}
            </Formik>
        </Container>
    );
}

export default SignUp;
