import React from "react";
import '../index.css';
import {Col, Container, Image, Row} from "react-bootstrap";
import {useTranslation} from "react-i18next";


const Empty = (props) => {
    let {t} = useTranslation();
    return (
        <Container>

            <Image src={"/images/empty.png"} width={"50%"} height={"80%"}/>
            <Row>
                <Col><h1 style={{color: "#0091FF"}}>{t("NoItemsFound")}</h1></Col>
            </Row>

        </Container>
    );
}

export default Empty;
