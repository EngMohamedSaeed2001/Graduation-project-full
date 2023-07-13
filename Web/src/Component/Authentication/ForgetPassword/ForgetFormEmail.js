import React, {useState} from "react";
import '../../../index.css';


import {Button, Container, FloatingLabel, Form, Row, Spinner} from "react-bootstrap";
import {Formik} from 'formik';
import {object, string} from 'yup';
import {Navigate} from "react-router-dom";
import ToastMsg from "../../../Helper/Toast";


const schema = object({

    email: string().required(),
});

const ForgetFormEmail = () => {
    let [email, setEmail] = useState("");
    let [loadButton, setLoadButton] = useState(true);
    let [wait, setWait] = useState(false);
    let [wrong, setWrong] = useState(false);
    let [msg, setMsg] = useState("");


    if (wait) {

        setTimeout(() => {
            setLoadButton(true)
        }, 1000)
        return <Navigate to={'/ForgetPasswordWait'}/>
    }

    return (
        <Container>
            <Formik
                validationSchema={schema}
                onSubmit={console.log}
                initialValues={{
                    email: null,
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

                    <Container className="opinion">
                        <h2>Send Your Email</h2>
                        <ToastMsg show={wrong} setShow={() => setWrong(false)} msg={msg}/>

                        <Form noValidate>
                            <Row className="inputs-forget">
                                <FloatingLabel
                                    controlId="floatingInput"
                                    label="Email address"
                                    className="mb-3 label"
                                >
                                    <Form.Control type="email" placeholder="name@example.com"
                                                  name="email"
                                                  value={values.email}
                                                  onChange={handleChange}
                                                  isInvalid={!!errors.email}
                                                  className="label"
                                    />

                                    <Form.Control.Feedback className="feedback" type="invalid" tooltip>
                                        {errors.email}
                                    </Form.Control.Feedback>
                                    {setEmail(values.email)}

                                </FloatingLabel>
                            </Row>

                            <Row className="inputs-forget">

                                <Button disabled={values.email === null} className="buttons"
                                        onClick={() => {
                                            localStorage.setItem("user_email", email)
                                            setWait(true)
                                            setLoadButton(false);
                                        }}>

                                    Send
                                    {loadButton ?
                                        null
                                        :
                                        <Spinner animation="border" size={"sm"}
                                                 style={{color: "#ffffff", marginLeft: "8%"}}/>
                                    }

                                </Button>

                            </Row>

                        </Form>
                    </Container>
                )}
            </Formik>
        </Container>
    );
}

export default ForgetFormEmail;
