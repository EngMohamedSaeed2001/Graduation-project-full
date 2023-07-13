import {useTranslation} from "react-i18next";
import {Col, Container, Image, Row} from "react-bootstrap";
import React from "react";

import MobileStoreButton from 'react-mobile-store-button';

export default function Sell() {
    let {t} = useTranslation()
    const iOSUrl = '';
    const androidUrl = '';


    return (
        <Container fluid style={{height: "100vh", marginTop: "20px", marginBottom: "40px"}}>
            <Container className="otp">

                <Image
                    src={"/images/logo/logo2.png"} width={"50%"}/>

                <h2 style={{color: "#060C43"}}>
                    {t("useApp")}
                </h2>


                <Row style={{marginTop: "40px"}}>
                    <Col>
                        <MobileStoreButton
                            width={200}
                            height={200}
                            store="android"
                            url={androidUrl}
                            linkProps={{title: 'Android Store Button'}}
                        />

                    </Col>

                    <Col style={{marginTop: "12px"}}>
                        <MobileStoreButton
                            width={200}
                            height={200}
                            store="ios"
                            url={iOSUrl}
                            linkProps={{title: 'iOS Store Button'}}
                        />

                    </Col>
                </Row>
            </Container>
        </Container>
    );
}