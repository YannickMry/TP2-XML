<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:template match="countries">
    <html>
        <head>
            <title>Pays</title>
            <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous" />
        </head>
        <body>
            <head>
                <nav class="navbar navbar-expand-lg navbar-light bg-light fixed-top">
                    <a class="navbar-brand" href="#">Pays</a>
                    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                        <span class="navbar-toggler-icon"></span>
                    </button>

                    <div class="collapse navbar-collapse" id="navbarSupportedContent">
                        <ul class="navbar-nav mr-auto">
                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle" href="#" id="dropAlpha" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                    Ordre alphabétique
                                </a>
                                <div class="dropdown-menu" aria-labelledby="dropAlpha">
                                    <xsl:apply-templates mode="link" select="country"/>
                                </div>
                            </li>
                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle" href="#" id="dropPop" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                    Population
                                </a>
                                <div class="dropdown-menu" aria-labelledby="dropPop">
                                    <xsl:apply-templates mode="link">
                                        <xsl:sort select="@population" order="descending" data-type="number"/>
                                    </xsl:apply-templates>
                                </div>
                            </li>
                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle" href="#" id="dropSup" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                    Superficie
                                </a>
                                <div class="dropdown-menu" aria-labelledby="dropSup">
                                    <xsl:apply-templates mode="link">
                                        <xsl:sort select="@area" order="descending" data-type="number"/>
                                    </xsl:apply-templates>
                                </div>
                            </li>
                        </ul>
                    </div>
                </nav>
            </head>
            <main class="container my-5">
                <div class="row">
                    <xsl:apply-templates mode="card"/>
                </div>
            </main>
            <footer>
                <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
                <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
                <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
            </footer>
        </body>
    </html>
    </xsl:template>
    <xsl:template match="country" mode="card">
        <div class="col-12 mt-5">
            <div class="card" id="{@name}">
                <div class="card-body">
                    <h5 class="card-title"><strong><xsl:value-of select="@name"/></strong></h5>
                    <table class="table">
                        <tr>
                            <th>Superficie</th>
                            <td><xsl:value-of select="@area"/></td>
                        </tr>
                        <tr>
                            <th>Population</th>
                            <td><xsl:value-of select="@population"/></td>
                        </tr>
                    </table>

                    <xsl:if test="city">
                        <h3>Liste des villes :</h3>
                        <div class="row">
                            <xsl:apply-templates select="city"/>
                        </div>
                    </xsl:if>
                    <xsl:if test="language">
                        <h3>Liste des langues :</h3>
                        <table class="table">
                            <tr>
                                <th>Nom</th>
                                <th>Pourcentage</th>
                            </tr>
                            <xsl:apply-templates select="language" order="descending"/>
                        </table>
                    </xsl:if>
                </div>
            </div>
        </div>
    </xsl:template>

    <xsl:template match="country" mode="link">
        <xsl:if test="position() &lt; 10">
            <a class="dropdown-item">
                <xsl:attribute name="href">#<xsl:value-of select="@name"/></xsl:attribute>
                <xsl:value-of select="@name"/>
            </a>
        </xsl:if>
    </xsl:template>

    <xsl:template match="city">
        <div class="col-4 mb-3">
            <li class="list-group-item d-flex justify-content-between align-items-center">
                <xsl:value-of select="name"/>
                <span class="badge badge-primary badge-pill">
                    <xsl:value-of select="population"/> hab.
                </span>
                <span class="badge badge-info badge-pill">
                    <xsl:value-of select="round(../@population div population * 100) div 100"/> %
                </span>
            </li>
        </div>
    </xsl:template>

    <xsl:template match="language">
        <tr>
            <th><xsl:apply-templates/></th>
            <td>
                <div class="progress">
                    <div class="progress-bar" role="progress" style="width: {@percentage}%" aria-valuemin="0" aria-valuemax="100"><xsl:value-of select="@percentage"/>%</div>
                </div>
            </td>
        </tr>
    </xsl:template>
</xsl:stylesheet>