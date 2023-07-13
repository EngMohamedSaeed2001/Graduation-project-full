import React from "react";
import '../../index.css';
import {Carousel, Container, Image} from "react-bootstrap";

import Load from "../../Helper/Load";
import Searcher from "../Search/Search";

const Header = (props) => {

    return (
        <>
            <Container fluid className="header" style={{paddingLeft: "0", paddingRight: "0"}}>
                <Searcher/>
                <Carousel variant="light">
                    {props.load ?
                        props.items.map(function (item, _) {
                            return (
                                <Carousel.Item key={item.id} style={{height: "400px"}}>
                                    <Image
                                        src={item.img}
                                        alt={item.name}
                                        style={{
                                            margin: "0 auto",
                                            width: "100%",
                                            height: "100%",
                                            backgroundSize: "cover"
                                        }}
                                    />
                                </Carousel.Item>
                            );
                        })
                        :
                        <Load style={{width: "80px", height: "80px", margin: "auto"}}/>
                    }

                </Carousel>
            </Container>
        </>

    );
}

export default Header;