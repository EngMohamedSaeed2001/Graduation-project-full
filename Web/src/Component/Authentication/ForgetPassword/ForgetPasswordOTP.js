import {useTranslation} from "react-i18next";
import {Button, Col, Container, Image, Row, Spinner} from "react-bootstrap";
import React, {useState} from "react";
import VerificationInput from "react-verification-input";
import {Navigate} from "react-router-dom";
import api from "../../../Apis/Base";

export default function ForgetPasswordOTP() {
    let {t} = useTranslation()
    let ss = "";
    let [otp, setOtp] = useState("")
    let [done, setDone] = useState(false);
    let [loadButton, setLoadButton] = useState(true);
    let [wait, setWait] = useState(false);
    let [wrong, setWrong] = useState(false);
    let [msg, setMsg] = useState("");
    let [resend, setResend] = useState(false)
    let timer = 60

    let email = localStorage.getItem("user_email")

    function verifyEmail() {
        api.api.post(`forgetPassword/checkOtp`, {
            email: email,
            otp: otp
        }).then((res) => {
            if (res.status === 200) {
                setWait(true);
                setLoadButton(false)
                setDone(false)
            }

        }).catch((e) => {

            setWrong(true)
            setMsg(e.response.data.message)
            setOtp("")
            setLoadButton(true)

        })
    }

    const sendOTP = () => {
        api.api.post("forgetPassword/", {
            email: email,
        }).then((res) => {
            if (res.status === 201) {
                localStorage.setItem("user_email", email)
            }

        }).catch((e) => {

            console.log(e.response.data.message)
            setWrong(true)
            setMsg(e.response.data.message)
            setLoadButton(true)
        })

    }


    function resendOTP() {
        setResend(true)
        timer = 60

        let downloadTimer = setInterval(function () {
            timer--
            document.getElementById("countdowntimer").textContent = timer;
            if (timer <= 0) {
                setResend(false)
                clearInterval(downloadTimer);
                setDone(false)
            }
        }, 1000);


    }

    if (wait) {
        return <Navigate to={`/forgetPassword/${otp}`}/>
    }
    return (
        <Container fluid style={{height: "100vh", marginTop: "20px", marginBottom: "40px"}}>
            <Container className="otp">

                <Image
                    src={"/images/waiting.png"} width={"100%"}/>

                <h5 style={{color: "#060C43", fontSize: "20px", margin: "20px"}}>
                    {t("verification")}
                </h5>

                <h6 style={{color: "#060C43", fontSize: "15px"}}>
                    {t("enterOtp")}
                </h6>

                <Row style={{margin: "40px"}}>
                    <VerificationInput classNames={{
                        container: "container",
                        character: "character",
                        characterInactive: "character--inactive",
                        characterSelected: "character--selected",
                    }} onChange={setOtp} value={otp}/>

                </Row>
                <Row style={{marginTop:"30%"}}>
                    <h6 style={{color: "#060C43", fontSize: "15px"}}>
                    {t("didntReceiveCode")}
                    <Button style={{color: "#FF0000", backgroundColor: "white", border: "none"}} disabled={done}
                            onClick={() => {
                                resendOTP()
                                sendOTP();
                                setDone(true)
                            }}>{t("resend")}</Button>
                </h6>
                </Row>
                {
                    resend ?
                        <Row>
                            <p style={{color: "black", fontSize: "15px"}}>{t("wewillSendAnOtpAfter")}<span
                                id="countdowntimer"
                                style={{color: "#FF0000", marginLeft: "5px"}}>60 </span> {t("seconds")}</p>
                        </Row>
                        : <></>
                }
                <Row>
                    <Col>
                        <Button disabled={otp.length !== 6} className={"buttonSubmit"}

                                onClick={() => {
                                    verifyEmail();

                                    setLoadButton(false);

                                }}>
                            {t("verify")}

                            {loadButton ?
                                null
                                :
                                <Spinner animation="border" size={"sm"}
                                         style={{color: "#ffffff", marginLeft: "8%"}}/>
                            }
                        </Button>
                    </Col>
                </Row>
            </Container>
        </Container>
    );
}