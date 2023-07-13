import React from "react";
import '../../App.css';
import {Col, Container, Row} from "react-bootstrap";
import {BsFacebook, BsFillArrowUpSquareFill, BsFillTelephoneFill, BsGoogle, BsTwitter} from "react-icons/bs";
import {Link} from "react-router-dom";
import {useTranslation} from "react-i18next";
import {MdEmail} from "react-icons/md";

const scrollToTop = () => {
    window.scrollTo({
        top: 0,
        behavior: "smooth",
    });
};


let cat = [];
let item = [];

const Footer = (props) => {
    let {t} = useTranslation();

    return (

        <Container fluid className="footer">

            <Container fluid style={{ paddingTop: "30px"}}>
                <Row>

                    <Col style={{float: "left"}}>

                        <img src={'images/logo/logo2.png'} srcSet={'images/logo/logo2.png'} style={{width: "280px"}}
                             alt={"logo"}/>

                    </Col>

                    <Col>

                    </Col>

                    <Col>

                    </Col>


                </Row>

                <Row style={{width: "100%", margin: "auto"}}>
                    <Col style={{marginTop: "15px",padding: "0", fontSize: "15px", fontWeight: "bold"}}>
                        <Row><h5>{t("contact")}</h5></Row>
                        <Row>
                            <Col><MdEmail style={{margin: "10px", fontSize: "15px", color: "#0091FF"}}/>SEMSARK@gmail.com</Col>
                        </Row>
                        <br/>
                        <Row>
                            <Col><BsFillTelephoneFill style={{margin: "10px", fontSize: "15px", color: "#0091FF"}}/>+2011111111111</Col>

                        </Row>

                    </Col>

                    <Col style={{marginTop: "15px",marginLeft: "15px", padding: "0", float: "right"}}>
                        <Row><h5>{t("services")}</h5></Row>
                        <Row><Link to="/buildingMenu/" className="footer-list">{t("buyHome")}</Link></Row>
                        <Row><Link to="/sell" className="footer-list">{t("sellHome")}</Link></Row>
                        <Row><Link to="/buildingMenu/rent" className="footer-list">{t("rentHome")}</Link></Row>

                    </Col>


                    <Col style={{marginTop: "15px", marginLeft: "15px", padding: "0", float: "right"}}>
                        <Row><h5>{t("other")}</h5></Row>
                        <Row><p className="footer-list">Privacy Policy</p></Row>
                        <Row><p className="footer-list">Cookie Policy</p></Row>
                        <Row><p className="footer-list">Terms & Conditions</p></Row>
                    </Col>


                    <Col style={{marginTop: "15px", marginLeft: "15px", padding: "0", fontWeight: "bold"}}>
                        <Row><h5>{t("social")}</h5></Row>
                        <Col>
                            <a target="_blank" href="/">
                                <BsFacebook/>
                            </a>
                        </Col>

                        <Col>
                            <a target="_blank" href="/">
                                <BsGoogle/>
                            </a>
                        </Col>
                        <Col>
                            <a target="_blank" href="/">
                                <BsTwitter/>
                            </a>
                        </Col>

                    </Col>

                </Row>


            <hr/>

            <Row style={{marginTop: "30px"}}>
                <Col style={{marginBottom: "35px"}}>
                    <p>Copyright &copy; 2022 <span className="logoColor">{t("app_title")}</span> All Rights Reserved.
                    </p>
                </Col>

                <Col xs={3}>
                    <BsFillArrowUpSquareFill onClick={() => {
                        scrollToTop()
                    }} className="footerIcon"/>
                </Col>
            </Row>

            </Container>

        </Container>

    );
}

export default Footer;