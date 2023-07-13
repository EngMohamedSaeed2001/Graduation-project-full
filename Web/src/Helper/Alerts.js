import React from "react";
import '../index.css';
import {Alert, Button} from "react-bootstrap";
import {Link} from "react-router-dom";
import {useTranslation} from "react-i18next";


const Alerts = (props) => {
    const {t} = useTranslation()
    return (
        <Alert show={props.show} variant="danger">
            <Alert.Heading>{props.msg}</Alert.Heading>

            <hr/>
            <div className="d-flex justify-content-end">
                <Link to={props.link}>
                    <Button onClick={props.setShow} variant="outline-danger">
                        {t('confirm')}
                    </Button>
                </Link>
            </div>
        </Alert>
    );
}

export default Alerts;
