import React, {useContext, useEffect, useState} from "react";
import '../../index.css';
import {Col, Container, Image, Nav, Row} from "react-bootstrap";
import Load from "../../Helper/Load";
import {useTranslation} from "react-i18next";
import i18n from '../Navbar/i18n'
import {BiPencil} from "react-icons/bi";
import {NavLink} from "react-router-dom";
import MyAds from "../UserAds/MyAds";
import Favorites from "../Favorites/Favorites";
import MyRequest from "../UserAds/MyRequest";
import Empty from "../../Helper/Empty";
import {UserContext} from "../../Context/UserContext";


let url = "";

let requests = []

const Profile = () => {
    let {ads,favs,image,load,username,email}=useContext(UserContext);

    let {t} = useTranslation();
      let [myAd, setMyAd] = useState(true)
    let [fav, setFav] = useState(false)
    let [myReq, setMyReq] = useState(false)




    return (
        <Container fluid>
            {

                load ?
                    (
                        <Container fluid style={{padding: "30px"}}>
                            <h3 style={{
                                textAlign: (i18n.language === 'en' ? "left" : "right"),
                                color: "#3E435D",
                                margin: "2% 4%",
                                fontFamily: "Poppins-Medium",
                                fontSize: "28px"
                            }}>{t("welcome")}{username}</h3>

                            <Row xs={2}>
                                <Col style={{textAlign: (i18n.language === 'en' ? "left" : "right"), marginLeft: "4%"}}>
                                    <Image width={"120px"} height={"120px"} roundedCircle
                                           src={url === "" ? image : url}/>
                                    <NavLink to={"/editProfile"}>
                                        <p style={{marginLeft: "6rem", marginTop: "-4%"}}>
                                            <BiPencil  color={"white"}  cursor="pointer" size={30} style={{margin: "auto",borderRadius:"50px",backgroundColor:"#45A6DD"}}/>
                                        </p>
                                    </NavLink>
                                </Col>

                                <Col style={{
                                    float:"left",
                                    marginLeft: (i18n.language === 'en' ? "15rem" : "0"),
                                    marginRight: (i18n.language === 'ar' ? "15rem" : "0"),
                                    marginTop: "-6%",
                                    textAlign: (i18n.language === 'en' ? "left" : "right")
                                }}>
                                    <h5 style={{
                                        color: "#000000",
                                        fontFamily: "Poppins-Medium",
                                        fontSize: "23px",
                                        fontWeight:"bold"
                                    }}>{username}</h5>
                                    <h6 style={{
                                        color: "#000000",
                                        opacity: "0.5",
                                        fontFamily: "Poppins-Regular",
                                        fontSize: "17px",
                                        wordBreak:"break-word"
                                    }}>{email}</h6>
                                </Col>

                            </Row>

                            <hr style={{marginTop: "40px", marginLeft: "10%", width: "78%", color: "#000000"}}/>

                            <Row style={{marginTop: "30px", width: "50%", marginLeft: "20%"}}>
                                <Nav fill variant="tabs" defaultActiveKey="#">
                                    <Nav.Item>
                                        <Nav.Link onClick={() => {
                                            setMyAd(true)
                                            setMyReq(false)
                                            setFav(false)
                                        }} style={{fontSize: "20px", fontFamily: "Poppins-Regular", wordSpacing: "5px"}}
                                                  href="#">{t("yourAds")}</Nav.Link>
                                    </Nav.Item>
                                    <Nav.Item>
                                        <Nav.Link onClick={() => {
                                            setFav(true)
                                            setMyReq(false)
                                            setMyAd(false)
                                        }} style={{
                                            fontSize: "20px",
                                            fontFamily: "Poppins-Regular",
                                            wordSpacing: "5px",
                                            textTransform: "uppercase"
                                        }} eventKey="link-1">{t("fav")}</Nav.Link>
                                    </Nav.Item>
                                    <Nav.Item>
                                        <Nav.Link onClick={() => {
                                            setMyReq(true)
                                            setMyAd(false)
                                            setFav(false)
                                        }} style={{fontSize: "20px", fontFamily: "Poppins-Regular", wordSpacing: "5px"}}
                                                  eventKey="link-2">{t("myRequest")}</Nav.Link>
                                    </Nav.Item>

                                </Nav>
                            </Row>
                            <Row style={{marginTop: "5%"}}>
                                {/*My ads*/}
                                {(myAd === true && myReq === false && fav === false) ? (ads.length !== 0 ?
                                    <MyAds items={ads} load={load}/> : <Empty/>) : <></>

                                }

                                {/*Favs*/}
                                {(myAd === false && myReq === false && fav === true) ? (favs.length !== 0 ?
                                    <Favorites items={favs} load={load}/> : <Empty/>) : <></>}


                                {/*Requests*/}
                                {(myAd === false && myReq === true && fav === false) ? (requests.length !== 0 ?
                                    <MyRequest items={requests} load={load}/> : <Empty/>) : <></>}

                            </Row>
                        </Container>
                    )
                    :

                    <Load style={{width: "80px", height: "80px"}}/>

            }
        </Container>
    )
}

export default Profile;