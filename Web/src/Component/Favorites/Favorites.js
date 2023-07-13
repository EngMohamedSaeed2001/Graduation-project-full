import {Card, Col, Row, Spinner} from "react-bootstrap";
import {NavLink} from "react-router-dom";
import {MdBed} from "react-icons/md";
import {FaBath, FaHeart} from "react-icons/fa";
import {BiArea} from "react-icons/bi";
import {GiSofa} from "react-icons/gi";
import {BsChatDots, BsFillTelephoneFill} from "react-icons/bs";
import {ImWhatsapp} from "react-icons/im";
import {FiHeart} from "react-icons/fi";
import React, { useState} from "react";
import {useTranslation} from "react-i18next";
import copy from "copy-to-clipboard";



export default function Favorites(props) {
    let {t} = useTranslation();


    const [heart, setHeart] = useState(true);



    const copyToClipboard = (e) => {
        copy(e);

        console.log(e)
    }

    function sendWhatsApp(phone) {
        let number = phone.replace(/[^\w\s]/gi, "").replace(/ /g, "");
        let url = `https://web.whatsapp.com/send?phone=+20${number}&text=${encodeURI("Hi / مرحبا")}&app_absent=0`;
        window.open(url);
    }

    return (
        <>
            {
                props.load === true ?
                    props.items.length !== 0 ?
                        (Array.apply(0, Array(1)).map(function (x, i) {
                                return (
                                    <Row id={i} lg={3} style={{marginLeft: "2%"}}>
                                        {
                                            props.items.map(function (item, ind) {
                                                return (
                                                    <Row>
                                                        <Col id={item.id} accessKey={item.id}>

                                                         <Card style={{width: '19rem'}} className={"item"} id={item.id}
                                                                  key={item.id}>
                                                                <NavLink to={`/building/${item.id}`}
                                                                         style={{textDecoration: "none", all: "unset"}}>
                                                                    <Card.Img variant="top" src={item.photosList[0].imgLink}/>

                                                                    <Card.Body>
                                                                        <Card.Title>
                                                                            <h6>{item.price} EGP</h6>

                                                                        </Card.Title>
                                                                        <Card.Text>
                                                                            <p>{item.address}</p>
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

                                                                         <Card.Footer>
                                                                    <BsFillTelephoneFill className={"item-icon"}
                                                                                         onClick={() => copyToClipboard(item.phone)}/>
                                                                    <NavLink to={"/chat/{id}"}>
                                                                        <BsChatDots className={"item-icon"}/>
                                                                    </NavLink>
                                                                    <ImWhatsapp style={{
                                                                        color: "#25d366",
                                                                        fontSize: "20px",
                                                                        marginLeft: "8px"
                                                                    }} onClick={() => sendWhatsApp(item.phone)}/>

                                                                    {
                                                                        heart === false ?
                                                                            <FiHeart className={"item-icon"}
                                                                                     onClick={() => setHeart(true)}/> :
                                                                            <FaHeart className={"item-icon"}
                                                                                     onClick={() => setHeart(false)}/>
                                                                    }

                                                                </Card.Footer>

                                                                    </Card.Body>
                                                                </NavLink>



                                                            </Card>
                                                        </Col>
                                                    </Row>
                                                )
                                            })
                                        }
                                    </Row>
                                )
                            })

                        ) :
                        <p style={{margin: "auto", fontSize: "25px", fontWeight: "bold", color: "grey"}}>
                            {t("noItemFound")}
                        </p>
                    :
                    <Spinner animation="grow"
                             style={{color: "#ed4e53", width: "80px", height: "80px", margin: "auto"}}/>
            }

        </>
    )

}