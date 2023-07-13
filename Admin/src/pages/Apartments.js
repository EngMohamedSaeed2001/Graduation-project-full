import React, {useEffect, useState} from 'react'

import PageTitle from '../components/Typography/PageTitle'

import {
    Avatar,
    Button, Input,
    Pagination,
    Table,
    TableBody,
    TableCell,
    TableContainer,
    TableFooter,
    TableHeader,
    TableRow,
} from '@windmill/react-ui'

import Form from 'react-bootstrap/Form';

import {SearchIcon, TrashIcon} from '../icons'

import response from '../utils/demo/tableData'
import {useTranslation} from "react-i18next";
import Api from "../utils/Base";
// make a copy of the data, for the second table
const response2 = response.concat([])

function Apartment() {


        // setup pages control for every table
    const [pageTable1, setPageTable1] = useState(1)
    const [pageTable2, setPageTable2] = useState(1)

    // setup data for every table
    const [dataTable1, setDataTable1] = useState([])
    const [dataTable2, setDataTable2] = useState([])
    let [ads,setAds]=useState([])

    const [searcher, setSearch] = useState("");
    const [suspend, setSuspend] = useState(false);
    const [open, setOpen] = useState(false);
    const [id, setId] = useState('0');

     const deleteAd = (id) => {
        setOpen(true);
        document.getElementById(id).style.display = "none";

         Api.apiToken.delete(`admin/deleteAd/${id}`).then((res) => {
            if (res.status === 200) {
            }
        }).catch((e) => {
            console.log(e.response.data.message)
        })

    }

    // pagination setup
    const resultsPerPage = 10
    const totalResults = response.length

    const search=(attr)=>{
        setSearch(attr.target.value)
    }

    // pagination change control
    function onPageChangeTable2(p) {
        setPageTable2(p)
    }

    // on page change, load new sliced data
    // here you would make another server request for new data

        const {t} = useTranslation()

     function allAds() {
        Api.apiToken.get("common/getAllAds").then((res) => {
            if (res.status === 200) {
                setAds(res.data)
            }

        }).catch((e) => {

            console.log(e.response.data.message)

        })
    }

    useEffect(() => {
     let canc = false;
        if (!canc) {
            setTimeout(() => {
                //setData(users.slice((page - 1) * resultsPerPage, page * resultsPerPage))
                allAds()

            }, 1000)
        }
        return () => {
            canc = true;
        }
    }, [pageTable2])


    return (
        <>
            <PageTitle>{t("apartments")}</PageTitle>

              <div className="flex justify-center flex-1 lg:mr-32" style={{marginBottom:"5%"}}>
          <div className="relative w-full max-w-xl mr-6 focus-within:text-blue-500">
            <div className="absolute inset-y-0 flex items-center pl-2"  >
              <SearchIcon className="w-4 h-4" aria-hidden="true" />
            </div>
            <Input
              className="pl-8 text-gray-700"
              placeholder={t("Searchbyid,title,phone,locationordate")}
              aria-label="Search"
              value={searcher}
              onChange={(e)=>search(e)}
            />
          </div>
        </div>


            <TableContainer className="mb-8">
                <Table>
                    <TableHeader>
                        <tr>
                           <TableCell>{t("buildingId")}</TableCell>
                            <TableCell>{t("Title")}</TableCell>
                            <TableCell>{t("date")}</TableCell>
                            <TableCell>{t("location")}</TableCell>
                            <TableCell>{t("client")}</TableCell>
                            <TableCell>{t("phone")}</TableCell>
                            <TableCell>{t("views")}</TableCell>
                            <TableCell>{t("action")}</TableCell>
                        </tr>
                    </TableHeader>
                    <TableBody>
                        { searcher!==""?
                            ads.filter((item)=>{
                return (item.id.toString().toLowerCase().includes(searcher.toLowerCase())||item.user.email.toLowerCase().includes(searcher.toLowerCase())||item.user.phone.toLowerCase().includes(searcher.toLowerCase())||item.date.toLowerCase().includes(searcher.toLowerCase())||item.city.toLowerCase().includes(searcher.toLowerCase())||item.gov.toLowerCase().includes(searcher.toLowerCase()))
            }).map((item, i) => (
                            <TableRow key={i} id={item.id}>
                                <TableCell>
                                    <span className="text-sm">{item.id}</span>
                                </TableCell>
                                  <TableCell>
                                    <span className="text-sm">{item.title}</span>
                                </TableCell>
                                 <TableCell>
                                    <span className="text-sm">{item.date}</span>
                                </TableCell>
                                 <TableCell>
                                    <span className="text-sm">{item.gov}/{item.city}</span>
                                </TableCell>
                                <TableCell>
                                    <div className="flex items-center text-sm">
                                        <Avatar className="hidden mr-3 md:block"
                                                src={item.photosList[0] ? item.photosList[0]: '/static/images/avatars/avatar.png'}
                                                alt="User avatar"/>
                                        <div>
                                            <p className="font-semibold">{item.user.email}</p>
                                        </div>

                                    </div>
                                </TableCell>

                                <TableCell>
                                    <p className={"font-semibold"}>{'0'+item.user.phone}</p>
                                </TableCell>

                                <TableCell>
                                    <span className="text-sm">{item.views}</span>
                                </TableCell>


                                <TableCell>
                                    <div className="flex items-center space-x-4">
                                        <Button layout="link" size="icon" aria-label="Delete"
                                                onClick={() => deleteAd(item.id)}>
                                            <TrashIcon className="w-5 h-5" aria-hidden="true"/>
                                        </Button>
                                    </div>
                                </TableCell>
                            </TableRow>
                        )):
                            (
                                 ads.map((item, i) => (
                              <TableRow key={i} id={item.id}>
                                <TableCell>
                                    <span className="text-sm">{item.id}</span>
                                </TableCell>
                                  <TableCell>
                                    <span className="text-sm">{item.title}</span>
                                </TableCell>
                                 <TableCell>
                                    <span className="text-sm">{item.date}</span>
                                </TableCell>
                                 <TableCell>
                                    <span className="text-sm">{item.gov}/{item.city}</span>
                                </TableCell>
                                <TableCell>
                                    <div className="flex items-center text-sm">
                                        <Avatar className="hidden mr-3 md:block"
                                                src={item.photosList[0] ? item.photosList[0] : '/static/images/avatars/avatar.png'}
                                                alt="User avatar"/>
                                        <div>
                                            <p className="font-semibold">{item.user.email}</p>
                                        </div>

                                    </div>
                                </TableCell>

                                <TableCell>
                                    <p className={"font-semibold"}>{'0'+item.user.phone}</p>
                                </TableCell>

                                <TableCell>
                                    <span className="text-sm">{item.views}</span>
                                </TableCell>

                                <TableCell>
                                    <div className="flex items-center space-x-4">
                                        <Button layout="link" size="icon" aria-label="Delete"
                                                onClick={() => deleteAd(item.id)}>
                                            <TrashIcon className="w-5 h-5" aria-hidden="true"/>
                                        </Button>
                                    </div>
                                </TableCell>
                            </TableRow>
                            )
                            ))

                        }
                    </TableBody>
                </Table>
                <TableFooter>
                    <Pagination
                        totalResults={totalResults}
                        resultsPerPage={resultsPerPage}
                        onChange={onPageChangeTable2}
                        label="Table navigation"
                    />
                </TableFooter>
            </TableContainer>
        </>
    )
}

export default Apartment;
