import {Col, Row, Toast} from "react-bootstrap";
import MobileStoreButton from "react-mobile-store-button";
import React, {useState} from "react";
import {useTranslation} from "react-i18next";

function Fixed() {
    let {t} = useTranslation()
    let [show, setShow] = useState(true)

    const iOSUrl = 'https://apps.apple.com/eg/app/olx-egypt/id1582817937';
    const androidUrl = 'https://play.google.com/store/apps/details?id=com.olxmena.horizontal&hl=ar&gl=US&pli=1';

    return (
        <>

            <Toast onClose={() => {
                setShow(false)
                localStorage.setItem("ad", 'false')
            }} show={show} delay={3000} style={{
                backgroundColor: "#82b5ce",
                padding: "20px",
                opacity: "0.9",
                width: "100%",
                bottom: "0",
                zIndex: "2",
                position: "fixed"
            }}>
                <Toast.Header style={{backgroundColor: "#82b5ce"}}>

                </Toast.Header>
                <Toast.Body>
                    <Row xs={"auto"} style={{marginBottom: "-50px",justifyContent:"center",alignItems:"center",alignContent:"center"}}>
                        <Col>
                            <h4 style={{color: "#060C43"}}>
                            {t("useApp")}
                        </h4>
                        </Col>
                        <Col>
                            <Row style={{marginTop:"10px"}}>
                                <Col>
                                    <MobileStoreButton
                                        width={95}
                                        height={95}
                                        store="android"
                                        url={androidUrl}
                                        linkProps={{title: 'Android Store Button'}}
                                    />

                                </Col>
                                <Col style={{marginTop: "4px"}}>
                                    <MobileStoreButton
                                        width={90}
                                        height={90}
                                        store="ios"
                                        url={iOSUrl}
                                        linkProps={{title: 'iOS Store Button'}}
                                    />
                                </Col>
                            </Row>
                        </Col>
                    </Row>
                </Toast.Body>

            </Toast>
        </>
    );
}

export default Fixed;