import React from "react";
import '../index.css';
import {Spinner} from "react-bootstrap";


const Load = (props) => {
    return (
        <Spinner animation="grow" variant="info" style={{margin: "auto", width: "100px", height: "100px"}}/>
    );
}

export default Load;
