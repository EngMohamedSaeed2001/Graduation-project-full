import React, {useState} from 'react'
import {FiSend} from "react-icons/fi";
import {Button, Col, Form, Row} from "react-bootstrap";
import {useTranslation} from "react-i18next";
import api from "../../Apis/Base";
import moment from "moment"
import "../../index.css"

const ChatFooter = ({receiverEmail}) => {
    let {t} = useTranslation()
    const [message, setMessage] = useState("")
    let [status, setStatus] = useState(0)

    const handleTyping = () => {
        setStatus(1)
    }

    const handleSendMessage = () => {

        if (message.length !== 0) {
            api.apiToken.post("/chat-semsark", {
                receiverEmail: receiverEmail,
                message: message,
                status: status,
                date: moment(new Date()).format('DD-MM-YYYY HH:mm:ss').toString()
            }).then((res) => {
                if (res.status === 200) {
                    setMessage("")
                }
            }).catch((e) => {
                console.log(e)
                setMessage("")
            })
        }
    }


    return (
        <div className='chat__footer'>
            <Row style={{marginLeft: "10%",padding:"10px"}}  sm={2} md={2} lg={2}>

                    <Col>
                        <form>
                            <textarea
                            placeholder={t("writeMsg")}
                           className={"mssg"}
                            value={message}
                            onChange={e => setMessage(e.target.value)}
                            onKeyDown={handleTyping}
                            rows={4}
                            >

                            </textarea>

                        </form>
                    </Col>
                    <Col>
                        <Button className="sendBtn" onClick={() => handleSendMessage()}> <FiSend/></Button>

                    </Col>
                </Row>
        </div>
    )
}

export default ChatFooter