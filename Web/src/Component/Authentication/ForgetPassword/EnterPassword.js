import React, {useState} from "react";
import '../../../index.css';
import {Button, Container, FloatingLabel, Form, Row, Spinner} from "react-bootstrap";
import {Formik} from 'formik';
import {object, string} from 'yup';
import ReCAPTCHA from "react-google-recaptcha";
import {Navigate, useParams} from "react-router-dom";
import ToastMsg from "../../../Helper/Toast";
import validator from "validator";
import api from "../../../Apis/Base";
import Load from "../../../Helper/Load";

const schema = object({
    password: string().required(),
    confirmPassword: string().required(),
});

let show = false;

const EnterPassword = () => {
    const {otp} = useParams();
    let [wrong, setWrong] = useState(false);
    let [msg, setMsg] = useState("");
    let [loadButton, setLoadButton] = useState(true);
    let [hide, setHide] = useState(false);
    let [password, setPassword] = useState("");
    let [done, setDone] = useState(false);
    let [wait, setWait] = useState(false);
    let [email, setEmail] = useState("");


    const createPassword = () => {

        api.api.post("createPassword", {
            email: email,
            password: password,
            otp: otp
        }).then((res) => {
            if (res.status === 200) {

                localStorage.setItem("access_token", res.data.token)
                localStorage.setItem("set_auth", true)
                setWait(true);

            }

        }).catch((e) => {

            console.log(e.response.data.message)
            setWrong(true)
            setMsg(e.response.data.message)
            setLoadButton(true)
        })
    }

    // useEffect(() => {
    //
    //     api.api.post(`verifyEmail/${otp}`).then((res) => {
    //         if (res.status === 200) {
    //             show = true
    //             setEmail(res.data)
    //             setDone(false)
    //         }
    //
    //     }).catch((e) => {
    //         console.log(e)
    //     })
    //
    // }, [])

    if (wait === true) {

        setTimeout(() => {
            setLoadButton(true)
        }, 1000)
        return <Navigate to={'/'}/>
    }
    return (
        <Container fluid>
            <Formik
                validationSchema={schema}
                onSubmit={console.log}
                initialValues={{
                    password: '',
                    confirmPassword: '',
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

                    <Container className="information">
                        <h2>Enter Your Password</h2>

                        {
                            show ?
                                <Form noValidate>
                                    {hide ?
                                        <ToastMsg show={hide} setShow={() => setHide(false)}
                                                  msg={"Password doesn't match"}/>
                                        : null
                                    }
                                    <Row className="inputs">

                                        <FloatingLabel controlId="floatingPassword" className="label"
                                                       label="Enter new Password">
                                            <Form.Control
                                                type="password" placeholder="Enter new Password"
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
                                                    }}>It must be greater than 6 and less than 18 </p> : null

                                            }

                                            <Form.Control.Feedback className="feedback" type="invalid" tooltip>
                                                {errors.password}
                                            </Form.Control.Feedback>
                                        </FloatingLabel>
                                    </Row>

                                    <Row className="inputs">

                                        <FloatingLabel controlId="floatingPassword" className="label"
                                                       label="Confirm Password">
                                            <Form.Control
                                                type="password" placeholder="Confirm Password"
                                                name="confirmPassword"
                                                value={values.confirmPassword}
                                                onChange={handleChange}
                                                isInvalid={!!errors.confirmPassword}
                                            />
                                            <Form.Control.Feedback className="feedback" type="invalid" tooltip>
                                                {errors.confirmPassword}
                                            </Form.Control.Feedback>
                                            {
                                                values.password !== values.confirmPassword ?
                                                    <p style={{
                                                        color: "#c7393d",
                                                        fontSize: "16px",
                                                        textAlign: "left",
                                                        marginTop: "10px"
                                                    }}>
                                                        Password doesn't match !!
                                                    </p>
                                                    : null
                                            }
                                            {setPassword(values.password)}
                                        </FloatingLabel>
                                    </Row>

                                    <Row className="inputs">
                                        <ReCAPTCHA
                                            sitekey="6LeIxAcTAAAAAJcZVRqyHh71UMIEGNQ_MXjiZKhI"
                                            onChange={() => {
                                                if (values.password === values.confirmPassword)
                                                    setDone(false)
                                                else {
                                                    setHide(true);
                                                }
                                            }}
                                        />
                                    </Row>

                                    <Row className="inputs">

                                        <Button disabled={done} className="buttons"
                                                onClick={() => {
                                                    createPassword();
                                                    setLoadButton(false);
                                                }}
                                        >
                                            Confirm

                                            {loadButton ?
                                                null
                                                :
                                                <Spinner animation="border" size={"sm"}
                                                         style={{color: "#ffffff", marginLeft: "8%"}}/>
                                            }
                                        </Button>

                                    </Row>

                                </Form>
                                :
                                <Load style={{width: "80px", height: "80px"}}/>
                        }
                    </Container>

                )}

            </Formik>
        </Container>
    );
}

export default EnterPassword;
