import React, {useState} from "react";
import '../../index.css';
import {Container, Row} from "react-bootstrap";
import {IoMdSearch} from "react-icons/io";
import {Navigate} from "react-router-dom";
import {useTranslation} from "react-i18next";
import i18n from "../Navbar/i18n";


const Searcher = () => {
    const {t} = useTranslation()
    let [item, setItem] = useState("")
    let [check, setCheck] = useState(false)

    if (item !== "" && check)
        return <Navigate to={`/buildingMenu/${item}`}/>

    return (
        <>

            <Container fluid className="search">
                <Row style={{marginTop: "70px"}}>
                    <h1 style={{
                        fontFamily: "Hacen Vanilla,Regular",
                        fontWeight: "bold",
                        wordSpacing: "10px",
                        letterSpacing: "25px",
                        fontSize: "37px",
                        marginTop: "20px",
                        color: "#FFFFFF"
                    }}>{t("withyou")}</h1>
                </Row>
                <Row className="searchInput">

                    <IoMdSearch style={{
                        margin: "auto",
                        top: "15%",
                        left: (i18n.language === 'en' ? "87%" : 0),
                        right: (i18n.language === 'ar' ? "87%" : 0),
                        position: "absolute",
                        backgroundColor: "#45A6DD",
                        borderRadius: "50px",
                        width: "40px",
                        height: "40px"
                    }}
                                color="#fff"
                                size="50px"
                                onClick={() => setCheck(true)}
                    />

                    <input
                        type="search"
                        placeholder={t("search_placeholder")}
                        className="searchForm"
                        aria-label="Search"
                        onChange={(e) => setItem(e.target.value)}
                    />
                </Row>
            </Container>


        </>


    );
}

export default Searcher;