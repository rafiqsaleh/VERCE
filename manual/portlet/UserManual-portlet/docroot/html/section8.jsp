<%@page contentType="text/html" pageEncoding="UTF-8"%>
<meta http-equiv="Content-Type" content="text/html;" charset="utf-8">

<%@ include file="header.jsp" %>
<%@ include file="menu.jsp" %>
<div class="wy-body-for-nav">

    <div class="wy-grid-for-nav">

        <section data-toggle="wy-nav-shift" class="wy-nav-content-wrap">

            <nav class="wy-nav-top" aria-label="top navigation">

                <i data-toggle="wy-nav-top" class="fa fa-bars"></i>
                <a href="index.jsp">VERCE Portal Manual</a>

            </nav>

            <div class="wy-nav-content-custom">

                <div class="rst-content">

                                        <div role="navigation" aria-label="breadcrumbs navigation">

                        <ul class="wy-breadcrumbs">

                            <li><a href="index.html">Docs</a> &raquo;</li>

                            <li>8. Running SPECFEM3D_Cartesian simulations using your own data</li>

                            <li class="wy-breadcrumbs-aside">

                            </li>

                        </ul>

                        <hr/>
                    </div>
                    <div role="main" class="document" itemscope="itemscope" itemtype="http://schema.org/Article">
                        <div itemprop="articleBody">

                            <div class="section" id="running-specfem3d-cartesian-simulations-using-your-own-data">
                                <h1>8. Running SPECFEM3D_Cartesian simulations using your own data<a class="headerlink" href="#running-specfem3d-cartesian-simulations-using-your-own-data" title="Permalink to this headline"></a></h1>
                                <p>So far we have covered how to run a relatively simple simulation using data that are already loaded into the portal. While we hope to keep increasing the areas where meshes and models are currently available, it is also essential that users can upload their own velocity models, meshes, earthquake catalogues and station locations. In this section we will give a brief overview of what is needed for each of these inputs, and how they are submitted to the portal.</p>
                                <div class="section" id="creating-your-own-velocity-model">
                                    <h2>8.1 Creating your own velocity model<a class="headerlink" href="#creating-your-own-velocity-model" title="Permalink to this headline"></a></h2>
                                    <p>All of the velocity models currently loaded into the VERCE portal are based on regional travel time tomography models of the concerned area. It would be possible to construct an input velocity model based on a surface wave tomography or noise tomography, or even from a velocity model produced from active seismic techniques based on refraction or reflection seismic surveys. If you are interested in running a full waveform simulation in a new area, you will therefore acquire a published velocity model, or use a preliminary model from your own work or collaborations.</p>
                                    <p>The new velocity model should be defined in a 3D grid of points and the corresponding input file for the portal should be formatted as shown below (Figure 8.1) and saved as a text file, usually called tomography file.
                                    </p>
                                    <p>The velocity model you submit should be based on your tomography, and should deviate back to the regional or global 1D starting model at the edges of the 3D volume. The tomography file should be formatted as shown in the below (Figure 7.1), and saved as a text file.</p>
                                    <p>The grid spacing defined on the second row of the file depends upon the frequency of seismic wave you intend to simulate, as described in section 8.2. Once this file has been created, the velocity model can be uploaded along with the corresponding mesh as described in section 8.3.</p>
                                    <p>The variables input into the velocity model text file are defined as follows.
                                    </p>

                                    <a href='<%=request.getContextPath()%>/images/image14.jpg' target="_blank">
                                        <img alt="image0" src='<%=request.getContextPath()%>/images/image14.jpg' />
                                    </a>
                                    <p><strong>Figure 8.1:</strong> Format for an input velocity model. Image re-produced from the SPECFEM manual.</p>
                                    <p><strong>ORIG_X, ORIG_Y,</strong> &amp; <strong>ORIG_Z</strong>: are the coordinates of the initial grid points in the tomographic model in the x, y and z directions respectively.
                                    </p>
                                    <p><strong>END_X, END_Y,</strong> &amp; <strong>END_Z:</strong> are the coordinates of the final grid points in the tomographic model in the x, y and z directions respectively.
                                    </p>
                                    <p><strong>SPACING_X, SPACING_Y,</strong> &amp; <strong>SPACING_Z</strong>: describe the spacing between points of the tomography file in the x, y and z directions respectively.
                                    </p>
                                    <p><strong>NX, NY,</strong> &amp; <strong>NZ</strong>: describe the number of grid points in the x, y and z directions respectively.</p>
                                    <p><strong>VP_MIN</strong> &amp; <strong>VP_MAX:</strong> describe respectively the minimum and maximum P-wave velocity of the input file in <em>ms:sup:`-1`</em>.</p>
                                    <p><strong>VS_MIN</strong> &amp; <strong>VS_MAX</strong>: describe respectively the minimum and maximum S-wave velocity of the input file in <em>ms:sup:`-1`</em>.</p>
                                    <p><strong>RHO_MIN</strong> &amp; <strong>RHO_MAX</strong>: describe respectively the minimum and maximum density of the input file in <em>kg/m:sup:`3`</em>.</p>
                                </div>
                                <div class="section" id="creating-a-bespoke-mesh-for-your-area">
                                    <h2>8.2 Creating a bespoke mesh for your area<a class="headerlink" href="#creating-a-bespoke-mesh-for-your-area" title="Permalink to this headline"></a></h2>
                                    <p>Creating a mesh is the most complicated step in setting up a simulation in a new area. The mesh must be created so that it can account for the frequency of seismic waves at the seismic velocities that are found in the velocity model defined above.</p>
                                    <div class="section" id="meshing-parameters">
                                        <h3>8.2.1 Meshing parameters<a class="headerlink" href="#meshing-parameters" title="Permalink to this headline"></a></h3>
                                        <p>The spacing of the grid (<span class="math notranslate">\({\Delta}h\)</span>) depends upon the minimum seismic velocity in the wave speed model (<span class="math notranslate">\(v_{\min}\)</span>) and the frequency (
                                            <span class="math notranslate">\(1/To,\)</span>) to which you wish to resolve the wavefield in your simulations as shown in the equation below (Komatitsch et al., 2005):</p>
                                        <div class="math notranslate" id="equation-eq1">
                                            <span class="eqno">(1)<a class="headerlink" href="#equation-eq1" title="Permalink to this equation"></a></span>\[{\Delta}h = \ v_{\min}\text{\ T}_{o}\ \frac{n + 1}{f(n)}\]</div>
                                        <p>where <span class="math notranslate">\(\text{To}\)</span> is the shortest period that can be resolved, and
                                            <span class="math notranslate">\(n\)</span> is the degree of polynomials used to represent the wave field in the spectral element method. Seismic velocity usually increases with depth, thus, in order to have the same resolution everywhere in the model, element size should increase.</p>
                                        <p>The time integration algorithm used by SEM to solve the seismic wave equation is conditionally stable, i.e. there exists an upper limit to the value of the time step over which the calculations become unstable. The stability condition, namely the Courant stability condition, is given by (Komatitsch et al., 2005):</p>
                                        <div class="math notranslate" id="equation-eq2">
                                            <span class="eqno">(2)<a class="headerlink" href="#equation-eq2" title="Permalink to this equation"></a></span>\[{\Delta}t \leq C_{\max}\ \left( \frac{h}{v} \right)_{\min}\]</div>
                                        <p>where <span class="math notranslate">\({(\ \frac{{\Delta}h}{v}\ )}_{\min}\)</span> denotes the minimum ratio between the grid spacing and the P-wave velocity, and <span class="math notranslate">\(C_{\max}\)</span> is the highest possible value of the Courant number. Based on equation
                                            <a class="reference internal" href="#equation-eq1">(1)</a>, equation <a class="reference internal" href="#equation-eq2">(2)</a> can be written as</p>
                                        <div class="math notranslate" id="equation-eq3">
                                            <span class="eqno">(3)<a class="headerlink" href="#equation-eq3" title="Permalink to this equation"></a></span>\[{\Delta}t \leq C_{\max}\ \frac{v_{\min}}{v_{\max}}\ T_{o}\ \frac{n + 1}{f(n)}\]</div>
                                        <p>Finally, the mesh should also account for the topography of the Earth’s surface, or bathymetry if the modelled area includes oceanic areas.</p>
                                        
                                        <a href='<%=request.getContextPath()%>/images/image25.png' target="_blank">
                                            <img alt="image1" src='<%=request.getContextPath()%>/images/image25.png' />
                                        </a>
                                        <p><strong>Figure 8.2:</strong> Example of a hexahedral mesh built using GEOCUBIT. On the left of the figure we can see that the grid spacing increases with depth as the wave speed increases. The top surface of the mesh represents the topography of the area to be modelled.</p>
                                    </div>
                                    <div class="section" id="meshing-software">
                                        <h3>8.2.2 Meshing software<a class="headerlink" href="#meshing-software" title="Permalink to this headline"></a></h3>
                                        <p>Meshes that can be used with SPECFEM3D_Cartesian and within the portal can be produced using CUBIT/ TRELIS software. Unfortunately the CUBIT/TRELIS software is not free, although a 30 day trial licence can be downloaded. Full details of the commercial software can be found at the following link.</p>
                                        <p><a class="reference external" href="http://www.csimsoft.com/">http://www.csimsoft.com/</a></p>
                                        <p>This software is then used in conjunction with the free python based GeoCubit software developed at the INGV:</p>
                                        <p><a class="reference external" href="https://github.com/geodynamics/specfem3d/tree/devel/CUBIT_GEOCUBIT">https://github.com/geodynamics/specfem3d/tree/devel/CUBIT_GEOCUBIT</a></p>
                                        <p>A full description of how to create a mesh for SPECFEM3D_Cartesian implemented into the VERCE platform can be found here:</p>
                                        <p><a class="reference external" href="http://verce.eu/Training/UseVERCE/2015-7-VERCE-hexmeshing101.pdf">http://verce.eu/Training/UseVERCE/2015-7-VERCE-hexmeshing101.pdf</a></p>
                                    </div>
                                </div>
                                <div class="section" id="submitting-a-mesh-and-a-velocity-model">
                                    <h2>8.3 Submitting a mesh and a velocity model<a class="headerlink" href="#submitting-a-mesh-and-a-velocity-model" title="Permalink to this headline"></a></h2>
                                    <p>Once you have produced your mesh, you can take the ten mesh files listed in figure 8.3.1 and put them into a folder named ‘
                                        <em>mesh_MySimulationArea’</em>, where ‘<em>MySimulationArea’</em> is the name of the area you are studying. Then, zip this folder in a single zip file named ‘<em>mesh_ MySimulationArea.zip’</em>.</p>
                                    <p>Do the same with the tomography file formatted as outlined in section 8.1. The tomography file can have whatever name you want but must be put in a folder named ‘<em>velocity_ MySimulationArea’</em>. Finally, zip this folder in a single zip file named ‘<em>velocity_ MySimulationArea.zip’,
as shown in Figure 8.3.1</em>.</p>

                                    <a href='<%=request.getContextPath()%>/images/image35.png' target="_blank">
                                            <img alt="image2" src='<%=request.getContextPath()%>/images/image35.png' />
                                    </a>
                                    <p><strong>Figure 8.3.1:</strong> Creating the zip files needed to upload a new model to the VERCE platform. The left hand side shows the 10 mesh files that need to be included and uploaded. The right hand side shows the single velocity file that needs to be uploaded, along with the naming conventions for these files.</p>
                                    <p>Once these zip files have been created, they can be uploaded by clicking the link labelled ‘<strong>*Click here to submit a new mesh and velocity
model’*</strong> in the solver tab of the forward modelling page. This will bring up the parameter form shown in figure 8.3.2. The zipped mesh and velocity model files can then be uploaded to the portal from the local machine. The limits of the mesh area in latitude and longitude should also be input in the ‘mesh bounds’ section of the pop-up window. Finally click ‘Submit’ for the mesh and velocity model to be uploaded to the portal. The meshes and models are manually validated before they are made available to you and to all the users, so it can take several days for the mesh and model to be uploaded and ready to use.</p>
                                    <p>It is of course possible to upload meshes and models that only you or your group of users can use. In this case please specify it in the note box at the bottom of the parameter form.</p>

                                    <a href='<%=request.getContextPath()%>/images/image44.png' target="_blank">
                                            <img alt="image3" src='<%=request.getContextPath()%>/images/image44.png' />
                                    </a>
                                    <p><strong>Figure 8.3.2:</strong> The parameter form for inputting a new mesh and model into the VERCE platform.</p>
                                </div>
                                <div class="section" id="submitting-a-new-earthquake-catalogue">
                                    <h2>8.4 Submitting a new earthquake catalogue<a class="headerlink" href="#submitting-a-new-earthquake-catalogue" title="Permalink to this headline"></a></h2> 
                                    
                                    
                                    <p>If you wish to submit your own earthquake catalogue, you can do this on the ‘<em>File’</em> tab of the ‘Earthquakes’ page shown in figure 8.4. The catalogue must be uploaded in quakeML format. The easiest way to convert other earthquake catalogue formats to quakeML is using ObsPy. The earthquakes must have full details of the location and focal mechanism of all the events you are interested in modelling.</p>
                                    <p>The ObsPy command ‘<em>readEvents’</em> can be used to read in events that are in a range of text based formats (e.g. NDK &amp; ZMAP). The event data can then be written to a quakeML file using ‘<em>writeQuakeML’</em>. Full details on how to install ObsPy and access tutorials on ObsPy are given in appendix 3.</p>
                                    
                                    <a href='<%=request.getContextPath()%>/images/image54.png' target="_blank">
                                            <img alt="image4" src='<%=request.getContextPath()%>/images/image54.png' />
                                    </a>
                                    <p><strong>Figure 8.4:</strong> The input form for bespoke user input earthquake catalogues.
                                    </p>
                                </div>
                                <div class="section" id="submitting-a-new-station-catalogue">
                                    <h2>8.5 Submitting a new station catalogue<a class="headerlink" href="#submitting-a-new-station-catalogue" title="Permalink to this headline"></a></h2>
                                    <p>New seismic stations and networks can be input in a similar way using the upload form under the ‘File’ tab in the ‘Stations’ section shown in figure 8.5.1.</p>
                                    <p>The format of the input station file can be a simple list of station name, group (i.e. network name), longitude, latitude, depth and meters buried. Figure 8.5.2 shows an example of the station locations for the temporary Maule network in Central Chile, which is already loaded into the platform. Alternatively, the station file can be uploaded as an xml file by selecting this format in the drop down menu and choosing your appropriate file.</p>
                                    
                                    <a href='<%=request.getContextPath()%>/images/image64.png' target="_blank">
                                           <img alt="image5" src='<%=request.getContextPath()%>/images/image64.png' />
                                    </a>
                                    <p><strong>Figure 8.5.1:</strong> The input form for new seismic station networks.</p>

                                    <a href='<%=request.getContextPath()%>/images/image74.png' target="_blank">
                                           <img alt="image6" src='<%=request.getContextPath()%>/images/image74.png' />
                                    </a>
                                    <p><strong>Figure 8.5.2:</strong> The input format for stations and networks to be added to the VERCE platform.</p>
                                </div>
                            </div>

                        </div>

                    </div> 
                    <div class="rst-footer-buttons" role="navigation" aria-label="footer navigation">
                        <a href='<%=request.getContextPath()%>/html/glossary.jsp' class="btn btn-neutral float-right" title="1. Introduction to the VERCE platform" accesskey="n" rel="next">Next 
                                          <span class="fa fa-arrow-circle-right"></span> </a>

                        <a href='<%=request.getContextPath()%>/html/section7.jsp' class="btn btn-neutral" title="Table of Contents" accesskey="p" rel="prev"><span class="fa fa-arrow-circle-left"></span> Previous</a>
                    </div>
                    <%@ include file="footer.jsp" %>
                </div>
            </div>

        </section>

    </div>

</div>