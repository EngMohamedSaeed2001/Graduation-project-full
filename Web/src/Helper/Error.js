import React from "react";
import '../index.css';
import {Button, Container} from "react-bootstrap";
import {Link} from "react-router-dom";

const Error = (props) => {
    return (
        <Container fluid>
            <p className="zoom-area">{props.msg}</p>
            <Container className="error-container">
                <span>{props.one}</span>
                <span><span className="screen-reader-text">{props.two}</span></span>
                <span>{props.three}</span>
            </Container>
            <Container className="link-container">
                <Link to='/'>
                    <Button className="buttonSubmit">Back To Home</Button>
                </Link>
            </Container>
        </Container>
    );
}

export default Error;
