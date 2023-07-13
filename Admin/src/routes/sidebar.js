

const routes = [
    {
        path: '/app/dashboard', // the url
        icon: 'HomeIcon', // the component being exported from icons/index.js
        name: "dashboard", // name that appear in Sidebar
    },

    {
        path: '/app/customers',
        icon: 'PeopleIcon',
        name: 'customers',
    },
    {
        path: '/app/pendingRequests',
        icon: 'MailIcon',
        name: 'PendingRequests',
    },
    {
        path: '/app/apartments',
        icon: 'Building',
        name: 'apartments',
    },
    {
        // path: '/app/orders',
        path:"",
        icon: 'CartIcon',
        name: 'OrdersComingSoon',
    },

]

export default routes
