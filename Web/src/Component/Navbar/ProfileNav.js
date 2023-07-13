import React, {useState} from 'react'
import {useTranslation} from 'react-i18next'
import {Container, Dropdown, Image} from "react-bootstrap";
import {BsChat, BsPencil} from "react-icons/bs";
import {SlLogout} from "react-icons/sl";
import {CgProfile} from "react-icons/cg";
import api from "../../Apis/Base"

const ProfileIcon = ({width = 50, height = 50}) => (
    <Image roundedCircle width={30}
           src={"/images/avatar.png"}/>

)

export default function ProfileNav(props) {

    const {t} = useTranslation()
    let [alert, setAlert] = useState(false);


    function logout() {
        localStorage.setItem("set_auth", "false");
        localStorage.setItem("user_token", "");
        localStorage.setItem("user_email", "");



         api.apiToken.post("signOut").then((res) => {

            if (res.status === 200) {
            }

        }).catch((e) => {
            console.log(e)
        })
           setAlert(true)
        window.location.reload()

    }

    return (
        <Container>
            {/*<Alerts show={alert} setShow={() => {*/}
            {/*    setAlert(false);*/}
            {/*    window.location.reload()*/}
            {/*}} link={"/"}*/}
            {/*        msg={t('logout_msg')}/>*/}

            <Dropdown className={"globalIcon"} drop={"down-centered"}>
                <Dropdown.Toggle id="dropdown-basic" className={"globalIcon"}>
                    <ProfileIcon/>
                </Dropdown.Toggle>

                <Dropdown.Menu className={"globalIcon"} style={{boxShadow: "0px 0px 16px #D8D8D8"}}>


                    {props.login === true ? <>
                        <Dropdown.Item href="/profile">
                            <CgProfile style={{marginRight: "5px"}}/>
                            {t("myProfile")}
                        </Dropdown.Item>

                        <Dropdown.Item href="/editProfile">
                            <BsPencil style={{marginRight: "5px"}}/>
                            {t("editProfile")}
                        </Dropdown.Item>

                        <Dropdown.Item href="/chat">
                            <BsChat style={{marginRight: "5px"}}/>
                            {t("chats")}
                        </Dropdown.Item>

                        <Dropdown.Divider/>
                        <Dropdown.Item href="#" onClick={() => logout()}>
                            <SlLogout style={{marginRight: "5px"}}/>
                            {t("logout")}
                        </Dropdown.Item>
                    </> : <></>}
                </Dropdown.Menu>
            </Dropdown>
        </Container>
    )
}