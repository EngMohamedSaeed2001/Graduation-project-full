import React, {useContext, useEffect, useState} from "react";
import {Button, Carousel, Col, Container, Image, Row} from "react-bootstrap";
import Load from "../../Helper/Load";
import i18n from "../Navbar/i18n";
import {NavLink, useParams} from "react-router-dom";
import {BiArea} from "react-icons/bi";
import {useTranslation} from "react-i18next";
import {MdBed} from "react-icons/md";
import {FaBath, FaHeart, FaMapMarkerAlt,FaSignal} from "react-icons/fa";
import {GiSofa} from "react-icons/gi";
import {BsChatDots, BsEye, BsFillTelephoneFill} from "react-icons/bs";
import {ImWhatsapp} from "react-icons/im";
import {FiHeart} from "react-icons/fi";
import copy from "copy-to-clipboard";
import api from "../../Apis/Base";
import {BuildingContext} from "../../Context/BuildingContext";
import {UserContext} from "../../Context/UserContext";





export default function Building() {
    let {getBuilding,getFav,loadBuilding,username,image,flatImage,email,long,lat,heart,level,views,finished,single,numOfRoom,numOfBathroom,numOfHalls,area,price,types,des,date,gov,city,category,title,signalPower,phone,userId}=useContext(BuildingContext)
   let {ads}=useContext(UserContext)
    let d=[...ads]


    let {t} = useTranslation();

    const {id} = useParams();
    let [heart1, setHeart1] = useState(false);



 useEffect(()=>{
     getBuilding(id)
     getFav(id)

     console.log("a7a")
 },[])

    const addFav = () => {
        api.apiToken.post(`user/addFavourite/${id}`).then((res) => {
            if (res.status === 200) {
                setHeart1(true)
            } else
                setHeart1(false)
        }).catch((e) => {
            console.log(e)
            setHeart1(false)
        })
    }

    const deleteFav = () => {
        api.apiToken.delete(`user/de1eteFavourite/${id}`).then((res) => {
            if (res.status === 200) {
                setHeart1(false)
            } else
                setHeart1(true)
        }).catch((e) => {
            console.log(e)
            setHeart1(true)
        })
    }


    const copyToClipboard = (e) => {
        copy(e);
    }

    function sendWhatsApp(ph) {
        let number = ph.replace(/[^\w\s]/gi, "").replace(/ /g, "");
        let url = `https://web.whatsapp.com/send?phone=+20${number}&text=${encodeURI("Hi / مرحبا")}&app_absent=0`;
        window.open(url);
    }

    const showMap = (p1, p2) => {
        window.open("https://maps.google.com?q=" + p1 + "," + p2);
    };


    return (
        <Container fluid className={"building"}>
            {loadBuilding === true ?
                <Row>
                    <Col lg={true}>
                        <Carousel variant="light" >
                            {flatImage.map(function (item, indx) {
                                return (
                                    <Carousel.Item key={indx} style={{height: "100vh"}}>
                                        <Image
                                            src={item}
                                            alt={"photo"}
                                            style={{
                                                margin: "0 auto",
                                                width: "100%",
                                                height: "100%",
                                                backgroundSize: "cover",

                                            }}
                                        />
                                    </Carousel.Item>
                                );
                            })
                            }

                        </Carousel>

                    </Col>

                    <Col style={{marginTop:"50px"}}>
                        <Row xs={2}>
                            <Col style={{textAlign: (i18n.language === 'en' ? "left" : "right"), marginLeft: "4%"}}>
                                <Image width={"100px"} height={"100px"} roundedCircle
                                       src={image}/>
                            </Col>

                            <Col style={{
                                marginLeft: (i18n.language === 'en' ? "25%" : "0"),
                                marginRight: (i18n.language === 'ar' ? "22%" : "0"),
                                marginTop: "-8%",
                                textAlign: (i18n.language === 'en' ? "left" : "right")
                            }}>
                                <h5 style={{
                                    color: "#000000",
                                    fontFamily: "Poppins-Medium",
                                    fontSize: "20px"
                                }}>{username}</h5>

                                <h6 style={{
                                    color: "#000000",
                                    opacity: "0.5",
                                    fontFamily: "Poppins-Regular",
                                    fontSize: "15px"
                                }}>{email}</h6>
                            </Col>
                        </Row>
                        <Row>
                            <Col style={{
                                textAlign: (i18n.language === 'en' ? "left" : "right"),
                                marginLeft: "4%",
                                marginTop: "5%"
                            }}>
                                <Row>
                                    <Col><h4>{category.toLowerCase().includes("rent") ? t("forRent") : t("forSelling")}</h4></Col>
                                    <Col style={{fontWeight:"bold"}}><BsEye size={20}/> {views}</Col>
                                    <Col>

                                    </Col>
                                </Row>
                                <h5 style={{fontWeight: "bold"}}> {price + "  "} {t("egp")}</h5>
                               <h6>{date}</h6>
                                <p>{finished === 1 ? t("finished") : t("notFinished")}</p>
                                <p>{t("level") + " :  " + level}</p>
                                <p>{gov + "  /  "}{city}</p>
                                {/*<p>{address}</p>*/}
                                <p style={{
                                    color: "#0091FF",
                                    fontSize: "20px",
                                    fontWeight: "bold"
                                }}>{types.toLowerCase().includes("villa") ? t("villa") : types.toLowerCase().includes("apartment") ? t("apartment") : types.toLowerCase().includes("duplex") ? t("duplex") : types}</p>
                                <hr/>
                            </Col>

                        </Row>

                        <Row style={{backgroundColor: "#F8F9F9"}}>
                            <h4 style={{
                                textAlign: (i18n.language === 'en' ? "left" : "right"),
                                marginLeft: "4%",
                                marginTop: "5%"
                            }}>{t("facilities")}</h4>
                            <Row style={{marginLeft: "0%"}} xs={6} className={"building"}>
                                <Col>
                                    <MdBed className={"item-icon"}/>
                                    {numOfRoom}
                                </Col>
                                <Col>
                                    <FaBath className={"item-icon"}/>
                                    {numOfBathroom}
                                </Col>
                                <Col>
                                    <BiArea className={"item-icon"}/>
                                    {area}
                                </Col>
                                <Col>
                                    <GiSofa className={"item-icon"}/>
                                    {numOfHalls}
                                </Col>

                                <Col>
                                    <FaSignal className={"item-icon"}/>
                                    {signalPower}
                                </Col>

                            </Row>
                        </Row>

                        <Row>
                            <h4 style={{
                                textAlign: (i18n.language === 'en' ? "left" : "right"),
                                marginLeft: "4%",
                                marginTop: "5%"
                            }}>{t("description")}</h4>
                            <p style={{color: "#76777C"}}>
                                {des}
                            </p>
                        </Row>

                        <Row>
                            <h4 style={{
                                textAlign: (i18n.language === 'en' ? "left" : "right"),
                                marginLeft: "4%",
                                marginTop: "5%"
                            }}>{t("map")}</h4>
                            <Button onClick={() => showMap(lat, long)} style={{
                                backgroundColor: "#3898d2",
                                boxShadow: "0px 0px 16px #45A6DD",
                                color: "white",
                                width: "20%",
                                cursor: "pointer",
                                margin: "5%"
                            }}>
                                <FaMapMarkerAlt style={{marginRight: "5px"}}/>
                                {t("show")}
                            </Button>
                        </Row>

                        <hr/>

                        {
                           d.length> 0?d.map((it, _) => {
                                    // eslint-disable-next-line no-unused-expressions
                                    it.user.userId === userId ? "" : <Row style={{margin: "5%"}} xs={6}>

                                        <Col>
                                            <BsFillTelephoneFill className={"item-icon"}
                                                                 onClick={() => copyToClipboard(phone)}/>
                                        </Col>
                                        <Col>
                                            <NavLink to={`/single-chat/${userId}/${username}/`}>
                                                <BsChatDots className={"item-icon"}/>
                                            </NavLink>
                                        </Col>
                                        <Col>
                                            <ImWhatsapp style={{
                                                color: "#25d366",
                                                fontSize: "30px",
                                                marginLeft: "8px",
                                                marginTop: "8px",
                                                cursor: "pointer"
                                            }} onClick={() => sendWhatsApp(phone)}/>

                                        </Col>
                                        <Col>
                                            {
                                                heart1 === false ? <FiHeart className={"item-icon"}
                                                                            onClick={() => addFav()}/> :
                                                    <FaHeart className={"item-icon"}
                                                             onClick={() => deleteFav()}/>
                                            }
                                        </Col>

                                    </Row>
                                }
                            )
                               :
                                <Row style={{margin: "5%"}} xs={6}>

                                        <Col>
                                            <BsFillTelephoneFill className={"item-icon"}
                                                                 onClick={() => copyToClipboard(phone)}/>
                                        </Col>
                                        <Col>
                                            <NavLink to={`/single-chat/${userId}/${username}`}>
                                                <BsChatDots className={"item-icon"}/>
                                            </NavLink>
                                        </Col>
                                        <Col>
                                            <ImWhatsapp style={{
                                                color: "#25d366",
                                                fontSize: "30px",
                                                marginLeft: "8px",
                                                marginTop: "8px",
                                                cursor: "pointer"
                                            }} onClick={() => sendWhatsApp(phone)}/>

                                        </Col>
                                        <Col>
                                            {
                                                heart1===false && heart===false? <FiHeart className={"item-icon"}
                                                                            onClick={() => addFav()}/> :
                                                    <FaHeart className={"item-icon"}
                                                             onClick={() => deleteFav()}/>
                                            }
                                        </Col>

                                    </Row>

                        }


                    </Col>
                </Row>
                :
                <Load style={{width: "80px", height: "80px", margin: "auto"}}/>
            }
        </Container>
    )
}