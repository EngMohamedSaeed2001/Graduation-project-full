import {Card, Col, Row, Spinner} from "react-bootstrap";
import {NavLink} from "react-router-dom";
import {MdBed} from "react-icons/md";
import {FaBath} from "react-icons/fa";
import {BiArea} from "react-icons/bi";
import {GiSofa} from "react-icons/gi";

import React from "react";
import {useTranslation} from "react-i18next";


export default function MyRequest(props) {
    let {t} = useTranslation()

    return (
        <>
            {
                props.load === true ?
                    props.items.length !== 0 ? (
                            Array.apply(0, Array(1)).map(function (x, i) {
                                return (
                                    <Row id={i} lg={3} style={{marginLeft: "2%"}}>
                                        {
                                            props.items.map(function (item, ind) {
                                                return (
                                                    <Row>
                                                        <Col id={item.id} accessKey={item.id}>

                                                            <Card style={{width: '19rem'}} className={"item request-card"}
                                                                  id={item.id}
                                                                  accessKey={item.id}>
                                                                <Col className={"card-overlay"}>
                                                                    <h5>{t("pending")}</h5>
                                                                </Col>
                                                                <NavLink to={`/building/${item.id}`}
                                                                         style={{textDecoration: "none", all: "unset"}}>
                                                                    <Card.Img variant="top" src={item.imgUrl}/>

                                                                    <Card.Body>
                                                                        <Card.Title><h6>{item.price} EGP</h6></Card.Title>
                                                                        <Card.Text>
                                                                            <p>{item.address}</p>
                                                                        </Card.Text>

                                                                        <Card.Text>
                                                                            <Row>
                                                                                <Col>
                                                                                    <MdBed className={"item-icon"}/>
                                                                                    {item.room}
                                                                                </Col>
                                                                                <Col>
                                                                                    <FaBath className={"item-icon"}/>
                                                                                    {item.bath}
                                                                                </Col>
                                                                                <Col>
                                                                                    <BiArea className={"item-icon"}/>
                                                                                    {item.area}
                                                                                </Col>
                                                                                <Col>
                                                                                    <GiSofa className={"item-icon"}/>
                                                                                    {item.reception}
                                                                                </Col>
                                                                            </Row>
                                                                        </Card.Text>

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