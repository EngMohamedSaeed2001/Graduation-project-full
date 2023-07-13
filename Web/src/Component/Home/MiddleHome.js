import React, {useState} from "react";
import '../../index.css';
import {Button, Card, Col, Container, Image, Row} from "react-bootstrap";
import "animate.css/animate.min.css";
import {AnimationOnScroll} from 'react-animation-on-scroll';
import {useTranslation} from "react-i18next";
import {MdBed, MdOutlineMapsHomeWork} from "react-icons/md";
import {FaBath} from "react-icons/fa";
import {BiArea} from "react-icons/bi";
import {GiSofa} from "react-icons/gi";
import {BsChatDots, BsEye, BsFillTelephoneFill} from "react-icons/bs";
import {ImWhatsapp} from "react-icons/im";
import copy from "copy-to-clipboard";
import {NavLink} from "react-router-dom";
import Load from "../../Helper/Load";


const MiddleHome = (props) => {
    let {t} = useTranslation();
    let [show, setShow] = useState(false)


    const copyToClipboard = (e) => {
        copy(e);
        setShow(true);
        console.log(e)
    }

    function sendWhatsApp(phone) {
        let number = phone.replace(/[^\w\s]/gi, "").replace(/ /g, "");
        let url = `https://web.whatsapp.com/send?phone=+20${number}&text=${encodeURI("Hi / مرحبا")}&app_absent=0`;
        window.open(url);
    }

    return (
        <Container className="header">

            <AnimationOnScroll animateIn="animate__fadeInLeftBig">
                <Row className="content">
                    <Col style={{padding: "20px"}}>
                        <Card style={{width: "100%", maxWidth: '18rem'}} className={"about-card"}>
                            <MdOutlineMapsHomeWork style={{fontSize: "100px", color: "#45A6DD", margin: "auto"}}/>
                            <Card.Body>
                                <Card.Title>
                                    <h5>{t("buyHome")}</h5>
                                </Card.Title>
                                <Card.Text>
                                    <p>
                                        Some quick example text to build on the card title and make up the
                                    </p>
                                </Card.Text>
                                <Button href={`/buildingMenu/all`} className={"button-rent"} >{t("search")}</Button>

                            </Card.Body>
                        </Card>
                    </Col>

                    <Col style={{padding: "20px"}}>
                        <Card style={{width: "100%", maxWidth: '18rem'}} className={"about-card"}>
                            <Image src="/images/sell.png" style={{width: "90px", margin: "auto"}}/>
                            <Card.Body>
                                <Card.Title>
                                    <h5>{t("sellHome")}</h5>
                                </Card.Title>
                                <Card.Text>
                                    <p>
                                        Some quick example text to build on the card title and make up the
                                    </p>
                                </Card.Text>
                                <Button href={"/sell"} className={"button-rent"}>{t("sell")}</Button>

                            </Card.Body>
                        </Card>
                    </Col>

                    <Col style={{padding: "20px"}}>
                        <Card style={{width: "100%", maxWidth: '18rem'}} className={"about-card"}>
                            <Image src="/images/rent.png" style={{width: "90px", margin: "auto"}}/>
                            <Card.Body>
                                <Card.Title>
                                    <h5>
                                        {t("rentHome")}
                                    </h5>
                                </Card.Title>
                                <Card.Text>
                                    <p>
                                        Some quick example text to build on the card title and make up the
                                    </p>
                                </Card.Text>
                                <Button href={"/buildingMenu/rent"} className={"button-rent"}>{t("findRent")}</Button>

                            </Card.Body>
                        </Card>
                    </Col>
                </Row>
            </AnimationOnScroll>


            {/*TWO MENUS*/}
            <Row className={"content"}>
                <h1 style={{
                    fontWeight: "bold",
                    fontFamily: "Avenir-Black",
                    fontSize: "49px",
                    color: "#000000"
                }}>{t("headContent")}</h1>
            </Row>
            <Row xs={"auto"} lg={3} className="content">
                {/*<Toast msg={t("copyMsg")} show={show} setShow={() => setShow(false)}/>*/}

                {
                    props.load === true ?

                        (
                            props.items.slice(0, 6).map(function (item, _) {
                                return (

                                    <Col style={{margin: "auto"}} key={item.id}>
                                        <Card style={{width: "100%", maxWidth: '19rem'}} className={"item"}
                                              key={item.id}>
                                            <NavLink to={`/building/${item.id}`}
                                                     style={{textDecoration: "none", all: "unset"}}>
                                                <Card.Img variant="top" style={{width:"100%",height:"150px"}} src={item.photosList[0]}/>

                                                <Card.Body>
                                                    <Card.Title>
                                                        <h6>{item.price} EGP</h6>
                                                        <BsEye size={16}/> {item.views}
                                                    </Card.Title>
                                                    <Card.Text>
                                                        <p>{item.gov} , {item.city}</p>
                                                    </Card.Text>

                                                    <Card.Text>
                                                        <Row>
                                                            <Col>
                                                                <MdBed className={"item-icon"}/>
                                                                {item.numOfRoom}
                                                            </Col>
                                                            <Col>
                                                                                <FaBath className={"item-icon"}/>
                                                                                {item.numOfBathroom}
                                                                            </Col>
                                                                            <Col>
                                                                                <BiArea className={"item-icon"}/>
                                                                                {item.area}
                                                                            </Col>
                                                                            <Col>
                                                                                <GiSofa className={"item-icon"}/>
                                                                                {item.numOfHalls}
                                                                            </Col>
                                                                        </Row>
                                                                    </Card.Text>

                                                                </Card.Body>
                                                            </NavLink>
                                            {
                                                props.ads.length > 0 ? props.ads.map((it, _) => {
                                                        // eslint-disable-next-line no-unused-expressions
                                                        return (
                                                            it.user.userId === item.user.userId ? "" :

                                                                <Card.Footer>


                                                                    <BsFillTelephoneFill
                                                                        className={"item-icon"}
                                                                        onClick={() => copyToClipboard(item.phone)}/>
                                                                    <NavLink
                                                                        to={`/single-chat/${item.user.userId}/${item.user.username}`}>
                                                                        <BsChatDots
                                                                            className={"item-icon"}/>
                                                                    </NavLink>
                                                                    <ImWhatsapp style={{
                                                                        color: "#25d366",
                                                                        fontSize: "20px",
                                                                        marginLeft: "8px"
                                                                    }}
                                                                                onClick={() => sendWhatsApp(item.phone)}/>


                                                                </Card.Footer>
                                                        )
                                                                   })

                                                                    :
                                                    <Card.Footer>


                                                        <BsFillTelephoneFill className={"item-icon"}
                                                                             onClick={() => copyToClipboard(item.phone)}/>
                                                        <NavLink
                                                            to={`/single-chat/${item.user.userId}/${item.user.username}`}>
                                                            <BsChatDots className={"item-icon"}/>
                                                        </NavLink>
                                                        <ImWhatsapp style={{
                                                            color: "#25d366",
                                                            fontSize: "20px",
                                                            marginLeft: "8px"
                                                        }} onClick={() => sendWhatsApp(item.phone)}/>


                                                    </Card.Footer>

                                            }


                                        </Card>
                                    </Col>

                                )
                            })

                        )

                        :
                        <Load
                            style={{width: "80px", height: "80px", margin: "auto"}}/>
                }


            </Row>

        </Container>
    );
}

export default MiddleHome;