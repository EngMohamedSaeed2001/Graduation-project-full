import {Card, Col, Row, Spinner} from "react-bootstrap";
import {NavLink} from "react-router-dom";
import {MdBed} from "react-icons/md";
import {FaBath} from "react-icons/fa";
import {BiArea} from "react-icons/bi";
import {GiSofa} from "react-icons/gi";

import React from "react";
import {useTranslation} from "react-i18next";
import {BsEye} from "react-icons/bs";



export default function MyAds(props) {
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

                                                        <Col id={item.id} key={item.id}>

                                                            <Card style={{width: '19rem'}} className={"item"} id={item.id}
                                                                  key={item.id}>
                                                                <NavLink to={`/building/${item.id}`}
                                                                         style={{textDecoration: "none", all: "unset"}}>
                                                                    <Card.Img variant="top" src={item.photosList[0]}/>

                                                                    <Card.Body>
                                                                        <Card.Title>
                                                                            <h6>{item.price} EGP</h6>
                                                                        <BsEye size={16}/> {item.views}
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

                                                                    </Card.Body>
                                                                </NavLink>



                                                            </Card>

                                                        </Col>

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