import React, {useContext, useEffect, useState} from "react";
import '../../index.css';
import {Button, Col, Container, Nav, Navbar, Row} from "react-bootstrap";
import ChangeLanguage from "./ChangeLanguage"
import Api from "../../Apis/Base";
import LocaleContext from '../../LocalContext';

import {useTranslation} from "react-i18next";
import ProfileNav from "./ProfileNav";
import {FiLogIn} from "react-icons/fi";

let em;
let re = true;
const Navs = (props) => {
    const {locale} = useContext(LocaleContext);

    const {t} = useTranslation()


    let [cancel, setCancel] = useState(false);
    let [items, setItem] = useState(0);
    let [cart, setCart] = useState(false);
    let [show, setShow] = useState(false);

    let [wait, setWait] = useState(false);
    let [login, setLogin] = useState(false);

    const get = () => {
        Api.apiToken.get(`user/getCart/${Api.email}`).then((res) => {
            if (res.status === 200) {
                setItem(res.data.orders.length)

            }
        }).catch((e) => {
            console.log(e)
        })
    }

    useEffect(() => {

        em = localStorage.getItem("user_email")
        document.title = t("app_title")



        setTimeout(() => {

            //get()

        }, 1000)

    }, [t])


    return (
        <>
            <Container fluid style={{fontSize: "18px"}}>
                <Row>
                    <Navbar style={{background: "transparent"}} collapseOnSelect expand="lg">
                        <Container fluid>

                            <Navbar.Brand href="/">
                                <img src={'images/logo/logo2.png'} srcSet={'images/logo/logo2.png'} width={180}/>
                            </Navbar.Brand>

                            <Navbar.Toggle aria-controls="responsive-navbar-nav"/>
                            <Navbar.Collapse id="responsive-navbar-nav">

                                <Nav className={locale === 'en' ? 'ms-auto' : 'me-auto'} style={{
                                    margin: "auto",
                                    fontFamily: "Avenir-Book",
                                    fontSize: "20px",
                                    wordSpacing: "90px"
                                }}>
                                    <Row>
                                        <Col>
                                            <Nav.Link className={"navs4"} href="/buildingMenu/all">{t('buy')}</Nav.Link>

                                        </Col>

                                        <Col>

                                            <Nav.Link className={"navs4"} href="/sell">{t('sell')}</Nav.Link>

                                        </Col>

                                        <Col>
                                            <Nav.Link className={"navs4"}
                                                      href="/buildingMenu/rent">{t('rent')}</Nav.Link>
                                        </Col>
                                    </Row>
                                </Nav>

                                {
                                    props.login === false ? (
                                            // <Nav className={locale === 'en' ? 'ms-auto' : 'me-auto'}>
                                                <Button href={"/login"} className={"button-rent"} style={{margin:"50px"}}>
                                                    <FiLogIn style={{marginRight: "5px"}}/>
                                                    {t("login")}
                                                </Button>
                                            // </Nav>
                                        ) :
                                        <></>
                                }
                                <Nav>
                                    <ProfileNav login={props.login}/>
                                </Nav>

                                <Nav style={{padding: "20px"}}><ChangeLanguage/></Nav>

                            </Navbar.Collapse>

                        </Container>
                    </Navbar>

                </Row>

            </Container>
            {/*<MenuPopUp show={show} setShow={() => setShow(false)}/>*/}


        </>


    );
}

export default Navs;