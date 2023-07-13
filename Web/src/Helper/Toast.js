import React from "react";
import {Col, Row, Toast} from "react-bootstrap";

function ToastMsg(props) {
    return (
        <Row style={{marginTop: "20px", marginLeft: "30px", marginBottom: "30px"}}>
            <Col xs={6}>
                <Toast onClose={props.setShow} show={props.show} delay={3000} autohide>
                    <Toast.Header></Toast.Header>
                    <Toast.Body>{props.msg}</Toast.Body>
                </Toast>
            </Col>
        </Row>
    );
}

export default ToastMsg;