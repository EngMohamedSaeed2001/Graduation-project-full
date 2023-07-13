import React, {useContext, useEffect} from 'react'
import {useTranslation} from 'react-i18next'
import {Container, Dropdown, Row} from "react-bootstrap";
import {BsGlobe} from "react-icons/bs";
import i18n from "./i18n";
import LocaleContext from '../../LocalContext';


const GlobeIcon = ({width = 50, height = 50}) => (
    <BsGlobe color={"black"} style={{fontSize: "25px"}}/>
)

export default function ChangeLanguage() {
    const {locale} = useContext(LocaleContext);

    function changeLocale(l) {
        if (locale !== l) {
            i18n.changeLanguage(l).then(r => "");
        }
    }

    // const currentLanguageCode = cookies.get('i18next') || 'en'
    // const currentLanguage = languages.find((l) => l.code === currentLanguageCode)
    const {t} = useTranslation()


    useEffect(() => {
        document.title = t('app_title')
    }, [t])

    return (
        <Container>
            <Row className="language-select iconNav">
                <Dropdown className={"globalIcon"}>
                    <Dropdown.Toggle id="dropdown-basic" className={"globalIcon"}>
                        <GlobeIcon/>
                    </Dropdown.Toggle>

                    <Dropdown.Menu className={"globalIcon"} style={{boxShadow: "0px 0px 16px #D8D8D8"}}>
                        <Dropdown.Item

                            onClick={() => changeLocale('en')}
                        >
                            English
                        </Dropdown.Item>

                        <Dropdown.Item href="#" onClick={() => changeLocale('ar')}>العربية</Dropdown.Item>

                    </Dropdown.Menu>
                </Dropdown>

            </Row>
        </Container>
    )
}